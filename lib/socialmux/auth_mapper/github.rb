module Socialmux
  module AuthMapper
    class Github < GuessName
      def url
        info.urls["GitHub"]
      end
    end
  end
end

