class App
  module Views

    class NewBookPost < Layout
      def author
        @new_book.authors
      end

      def title
        @new_book.title
      end

      def year
        @new_book.published_date[0..3]
      end

      def isbn
        @new_book.isbn
      end

      def first_page
        "1"
      end

      def last_page
        @new_book.page_count
      end

      def cover
        # @new_book.image_link(zoom: 5)
        @new_book.image_link
      end

      def cover_alt
        @new_book.image_link.nil? ? "No thumbnail available" : "#{title}, #{year}"
      end

      def link
        @new_book.info_link
      end
    end
  end
end
