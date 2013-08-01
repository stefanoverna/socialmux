module Socialmux
  module AuthMapper
    class GuessName < Base
      def first_name
        name_chunks.first
      end

      def last_name
        last_name = name_chunks.dup
        last_name.shift
        last_name.join(" ")
      end

      private

      def name_chunks
        info.name.split(/\s+/)
      end
    end
  end
end

