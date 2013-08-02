module Socialmux
  module AuthMapper
    class Facebook < Base
      def gender
        case data.extra.raw_info["gender"]
        when "male"
          Gender::MALE
        when "female"
          Gender::FEMALE
        else
          nil
        end
      end
    end
  end
end

