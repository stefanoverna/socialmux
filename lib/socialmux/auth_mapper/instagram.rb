module Socialmux
  module AuthMapper
    class Instagram < GuessName
      def url
        "http://instagram.com/#{nickname}"
      end

      def description
        info.bio
      end

      private

      def nickname
        info["nickname"]
      end
    end
  end
end

