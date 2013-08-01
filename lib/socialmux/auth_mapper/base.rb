require 'hashie'
require 'active_support/core_ext/module/delegation'

module Socialmux
  module AuthMapper
    class Base
      attr_reader :data

      delegate :uid, to: :data
      delegate :info, to: :data
      delegate :provider, to: :data

      delegate :first_name, to: :info
      delegate :last_name, to: :info
      delegate :email, to: :info
      delegate :image, to: :info
      delegate :description, to: :info

      def initialize(data)
        @data = Hashie::Mash.new(data)
      end
    end
  end
end

