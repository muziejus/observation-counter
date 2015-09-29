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

    def js_bigfoot
      @js_bigfoot
    end

    def add_book_button
      "<a href='/new-book' class='btn btn-primary btn-lg'>Add New Book</a>"
      # "<a href='/new-book' class='btn btn-primary btn-lg disabled'>Add New Book (disabled for demo)</a>"
    end

    def external_link_glyph(link)
      "<a href='#{link}' target='_blank'><span class='glyphicon glyphicon-new-window' aria-hidden='true'></span></a>"
    end

    def total_counts_for_scatter
      s = ""
      Book.all.each do |book|
        s = s + "{ x: #{book.totals[:pages]}, y: #{book.totals[:counts]}, r: #{Math.sqrt book.totals[:interval]}, title: '#{book.title}'}, " unless book.count_array == [0, 0] 
      end
      s.sub(/, $/, "") 
    end


  end
end
