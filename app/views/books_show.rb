class App
  module Views

    class BooksShow < Layout

      def books
        Book.all.map{ |b| { author: b.author, title: b.title, id: b.id, link: b.link, year: b.year, pages: b.last_page - b.first_page, observations_per_page: 0 } }
      end

    end
  end
end
