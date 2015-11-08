require "sinatra/base"
require "sinatra/assetpack"
require "mustache/sinatra"
require "haml"
require "googlebooks"
require_relative "./model"
require_relative "./stat"

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
      "/js/*.js", 
      # "/js/vendor/*.js"
    ]
    js :app_js_chart, [ "/js/vendor/Chart.js", "/js/vendor/Chart.Scatter.js" ]
    js :app_js_bigfoot, [ "/js/vendor/bigfoot.js" ]
    # js :app_js_chart, [ "/js/vendor/Chart.min.js" ]

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
    @js_chart = js :app_js_chart
    @js_bigfoot = js :app_js_bigfoot
    @path = request.path_info
  end

  helpers do

  end

  
  # Function allows both get / post.
  def self.get_or_post(path, opts={}, &block)
    get(path, opts, &block)
    post(path, opts, &block)
  end   

  get "/" do
    @page_title = "Home"
    mustache :index
  end

  get "/new-book" do
    @page_title = "Add New Book"
    mustache :new_book
  end

  post "/new-book" do
    @page_title = "Adding ISBN: #{params[:isbn]}"
    result = GoogleBooks.search("isbn:#{params[:isbn]}").first
    unless result.nil?
      @new_book = { author: result.authors,
                    title: result.title, 
                    year: result.published_date[0..3],
                    last_page: result.page_count,
                    cover: result.image_link,
                    link: result.info_link }
    else
      # clumsy kludge for when GoogleBooks returns a 
      @new_book = { author: "AUTHOR NOT FOUND", 
                    title: "TITLE NOT FOUND", 
                    year: "",
                    last_page: "",
                    cover: nil,
                    link: "" }
    end
    @isbn = params[:isbn] # sometimes google doesn't return one.
    mustache :new_book_post
  end

  post "/add-book" do
    @page_title = "Saving #{params[:title]}"
    saved_book = Book.new
    saved_book.attributes = { author: params[:author], title: params[:title], isbn: params[:readonlyISBN], first_page: params[:firstPage], last_page: params[:lastPage], cover: params[:cover], link: params[:link], year: params[:year] }
    begin
      saved_book.save
      redirect "/books/observations/#{saved_book.id}"
    rescue DataMapper::SaveFailureError => e
      haml :error, locals: { e: e, validation: saved_book.errors.values.join(', ') }
    rescue StandardError => e
      haml :error, locals: { e: e }
    end
  end

  get "/books/observations/:id" do
    @book = Book.get params[:id].to_i
    mustache :book_show
  end

  post "/add-observations" do
    @page_title = "Adding observations"
    Book.get(params[:id]).update(observations: params[:counts].map{ |k, v| v })
    redirect "/books/#{params[:id]}"
  end

  get "/books/:id" do
    @book = Book.get params[:id].to_i
    @page_title = "#{@book.title}"
    if @book.nil?
      redirect '/books'
    else
      mustache :book_show
    end
  end

  get "/books" do
    @page_title = "All Books"
    @books = Book.all
    mustache :books_show
  end

  get "/about" do
    @page_title = "About"
    mustache :about
  end

end
