require "sinatra/base"
require "sinatra/assetpack"
require "mustache/sinatra"
require "haml"
require "googlebooks"
require_relative "./model"

class App < Sinatra::Base
  base = File.dirname(__FILE__)
  set :root, base

  register Sinatra::AssetPack
  register Mustache::Sinatra

  assets do
    serve "/js",    from: "app/js"
    serve "/css",   from: "app/css"
    serve "/img",   from: "app/img"

    css :app_css, [ "/css/*.css" ]
    js :app_js, [
      "/js/*.js"
    ]
    #js :app_js_modernizr, [ "/js/vendor/modernizr-2.6.2.min.js" ]

    # Heroku doesn't like this call but assets end up minified anyway.
    # Left them in in for reference.
    #css_compression :sass
    #js_compression  :jsmin
  end

  require "#{base}/app/helpers"
  require "#{base}/app/views/layout"

  set :mustache, {
    :templates => "#{base}/app/templates",
    :views => "#{base}/app/views",
    :namespace => App
  }

  set :haml, {
    format: :html5,
    :views => "#{base}/app/views",
  }

  before do
    @css = css :app_css
    @js  = js  :app_js
  end

  helpers do

  end

  # Function allows both get / post.
  def self.get_or_post(path, opts={}, &block)
    get(path, opts, &block)
    post(path, opts, &block)
  end   

  get "/" do
    @page_title = "Novel Observer"
    mustache :index
  end

  get "/new-book" do
    @page_title = "Add New Book | Novel Observer"
    mustache :new_book
  end

  post "/new-book" do
    @page_title = "Adding ISBN: #{params[:isbn]} | Novel Observer"
    @new_book = GoogleBooks.search("isbn:#{params[:isbn]}").first
    mustache :new_book_post
  end

  post "/add-book" do
    @page_title = "Saving #{params[:title]} | Novel Observer"
    saved_book = Book.new
    saved_book.attributes = { author: params[:author], title: params[:title], isbn: params[:readonlyISBN], first_page: params[:firstPage], last_page: params[:lastPage], cover: params[:cover], link: params[:link], year: params[:year] }
    begin
      saved_book.save
      redirect "/books/#{saved_book.id}"
    rescue DataMapper::SaveFailureError => e
      haml :error, locals: { e: e, validation: saved_book.errors.values.join(', ') }
    rescue StandardError => e
      haml :error, locals: { e: e }
    end
  end

  post "/add-observations" do
    Book.get(params[:id]).update(observations: params[:counts].map{ |k, v| v })
    redirect "/books/#{params[:id]}"
  end

  get "/books/:id" do
    @book = Book.get params[:id].to_i
    if @book.nil?
      redirect '/books'
    else
      mustache :book_show
    end
  end

  get "/books" do
    @books = Book.all
    mustache :books_show
  end

  get "/about" do
    @page_title = "About | Novel Observer"
    mustache :about
  end

end
