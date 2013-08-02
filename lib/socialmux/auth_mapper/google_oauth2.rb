module Socialmux
  module AuthMapper
    class GoogleOauth2 < Base
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

