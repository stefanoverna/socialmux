require 'hashie'
require 'active_support/inflector'

require 'socialmux/auth_mapper/base'
require 'socialmux/auth_mapper/guess_name'
require 'socialmux/auth_mapper/facebook'
require 'socialmux/auth_mapper/twitter'
require 'socialmux/auth_mapper/github'
require 'socialmux/auth_mapper/google_oauth2'
require 'socialmux/auth_mapper/linkedin'
require 'socialmux/auth_mapper/instagram'

module Socialmux
  module AuthMapper
    class NotFound < RuntimeError; end

    def self.init_with_data(data)
      data = Hashie::Mash.new(data)
      klass_name = "Socialmux::AuthMapper::#{data.provider.to_s.classify}"
      klass = klass_name.constantize
      klass.new(data)

    rescue NameError
      raise NotFound, "Mapper for provider #{data.provider} not found!"
    end
  end
end

