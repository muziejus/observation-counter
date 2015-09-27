class App
  module Views

    class BooksShow < Layout
      include ViewHelpers

      def books
        @books.map{ |b| { author: b.author, title: b.title, id: b.id, link: b.link, year: b.year, pages: b.last_page - b.first_page, observations_per_page: observations_per_page(observations_list(b)) } }
      end

      def labels
        s = ""
        @books.each{ |book| s = s + "'#{book.title}', " }
        s.sub(/, $/, "")
      end
      
      def averages
        s = ""
        @books.each{ |book| s = s + "#{observations_list(book).mean}, " }
        s.sub(/, $/, "")
      end

      def confidence_intervals
        s = ""
        @books.each{ |book| s = s + "#{confidence_interval(observations_list(book))}, " }
        s.sub(/, $/, "")
      end

    end
  end
end
