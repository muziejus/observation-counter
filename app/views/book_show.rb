class App
  module Views

    class BookShow < Layout
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
