module Socialmux
  module AuthMapper
    class Twitter < GuessName
      def url
        info.urls["Twitter"]
      end
    end
  end
end

