class App
  module Views

    class BooksShow < Layout

      def books
        Book.all.map{ |b| { author: b.author, title: b.title, id: b.id, link: b.link, year: b.year, pages: b.last_page - b.first_page, observations_per_page: 0 } }
      end

      # def author
      #   @book.author
      # end

      # def title
      #   @book.title
      # end

      # def year
      #   @book.year
      # end

      # def isbn
      #   @book.isbn
      # end

      # def first_page
      #   @book.first_page
      # end

      # def last_page
      #   @book.last_page
      # end

      # def cover
      #   @book.cover
      # end

      # def cover_alt
      #   "#{title}, #{year}"
      # end

      # def link
      #   @book.link
      # end
    end
  end
end
