class App
  module Views

    class BookShow < Layout

      def observations
        @book.observations.all.map { |o| {page: o.page, count: o.count, id: o.id } }
      end

      def observations_table
        if @path =~ /books.observations/
        # if @book.observations.all.length == 0
          false
        else
          true
        end
      end
      
      def count_per_page_single
        if @book.count_array == [0, 0]
          "[Currently Pending]"
        else
          "#{@book.count_per_page}"
        end
      end

      def external_link
        external_link_glyph(@book.link)
      end

      def pages
        (@book.first_page..@book.last_page).map{ |p| p }.sample(20).sort.map { |pp| { page: pp } }
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
