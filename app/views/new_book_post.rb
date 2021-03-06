class App
  module Views

    class NewBookPost < Layout
      def author
        @new_book[:author]
      end

      def title
        @new_book[:title]
      end

      def year
        @new_book[:year]
      end

      def isbn
        @isbn
      end

      def first_page
        "1"
      end

      def last_page
        @new_book[:last_page]
      end

      def cover
        # @new_book.image_link(zoom: 5)
        @new_book[:cover]
      end

      def cover_alt
        @new_book[:cover].nil? ? "No thumbnail available" : "#{title}, #{year}"
      end

      def link
        @new_book[:link]
      end
    end
  end
end
