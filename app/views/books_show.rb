class App
  module Views

    class BooksShow < Layout
      include ViewHelpers

      def books
        @books.map{ |b| { author: b.author, title: b.title, id: b.id, link: b.link, external_link: external_link_glyph(b.link), year: b.year, pages: b.total_pages, count_per_page: b.count_per_page } }
      end

      def labels
        s = ""
        @books.each{ |book| s = s + "'#{book.title}', " unless book.count_array == [0, 0] }
        s.sub(/, $/, "")
      end
      
      def averages
        s = ""
        @books.each{ |book| s = s + "#{book.count_array.mean}, " unless book.count_array == [0, 0] }
        s.sub(/, $/, "")
      end

      def confidence_intervals
        s = ""
        @books.each{ |book| s = s + "#{book.count_confidence_interval}, " unless book.count_array == [0, 0] }
        s.sub(/, $/, "")
      end

    end
  end
end
