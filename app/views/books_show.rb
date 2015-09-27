class App
  module Views

    class BooksShow < Layout
      include ViewHelpers

      def books
        @books.map{ |b| { author: b.author, title: b.title, id: b.id, link: b.link, external_link: external_link_glyph(b.link), year: b.year, pages: b.last_page - b.first_page, count_per_page: count_per_page(count_list(b)) } }
      end

      def labels
        s = ""
        @books.each{ |book| s = s + "'#{book.title}', " }
        s.sub(/, $/, "")
      end
      
      def averages
        s = ""
        @books.each{ |book| s = s + "#{count_list(book).mean}, " }
        s.sub(/, $/, "")
      end

      def confidence_intervals
        s = ""
        @books.each{ |book| s = s + "#{confidence_interval(count_list(book))}, " }
        s.sub(/, $/, "")
      end

    end
  end
end
