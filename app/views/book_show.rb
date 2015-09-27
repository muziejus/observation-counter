class App
  module Views

    class BookShow < Layout

      def observations
        @book.observations.all.map { |o| {page: o.page, count: o.count, id: o.id } }
      end

      def observations_table
        if @book.observations.all.length == 0
          false
        else
          true
        end
      end

      def pages
        (@book.first_page..@book.last_page).map{ |p| p }.sample(30).sort.map { |pp| { page: pp } }
      end

      def id
        @book.id
      end

      def author
        @book.author
      end

      def title
        @book.title
      end

      def year
        @book.year
      end

      def isbn
        @book.isbn
      end

      def first_page
        @book.first_page
      end

      def last_page
        @book.last_page
      end

      def cover
        @book.cover
      end

      def cover_alt
        "#{title}, #{year}"
      end

      def link
        @book.link
      end
    end
  end
end
