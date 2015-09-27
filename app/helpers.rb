class App
  module ViewHelpers

    def stylesheets
      @css
    end

    def javascripts
      @js
    end

    def observations_list(book)
      if book.observations.length == 0
        [0, 0]
      else
        book.observations.map{ |o| o[:count] }
      end
    end

    def observations_per_page(observations)
      if observations == [0, 0]
        "Sample pending"
      else
        "#{observations.mean} ± #{confidence_interval observations}"
      end
    end

    def confidence_interval(observations)
      (2.093*(observations.standard_deviation/Math.sqrt(20))).round(3)
    end

  end
end
