# Helper methods defined here can be accessed in any controller or view in the application

module Buildathing
  class App
    module Helper
      def title
        if !@title.nil? && !@title.empty?
          "| #{@title}"
        else
          ""
        end
      end
    end

    helpers Helper
  end
end
