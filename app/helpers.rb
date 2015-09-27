class App
  module ViewHelpers

    def stylesheets
      @css
    end

    def javascripts
      @js
    end

    def js_chart
      @js_chart
    end

    def count_list(book)
      if book.observations.length == 0
        [0, 0]
      else
        book.observations.map{ |o| o[:count] }
      end
    end

    def count_per_page(count_list)
      if count_list == [0, 0]
        "Sample pending"
      else
        "#{count_list.mean} ± #{confidence_interval count_list}"
      end
    end

    def confidence_interval(count_list)
      (2.093*(count_list.standard_deviation/Math.sqrt(20))).round(3)
    end

  end
end
