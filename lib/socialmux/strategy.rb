require 'active_support/core_ext/hash/reverse_merge'
require 'active_support/core_ext/hash/keys'

module Socialmux
  class Strategy
    attr_reader :adapter
    attr_reader :current_user
    attr_reader :data
    attr_reader :user_params

    def initialize(options)
      options.assert_valid_keys(:adapter,
                                :current_user,
                                :data,
                                :user_params)

      options.each do |key, value|
        instance_variable_set "@#{key}", value
      end
    end

    def result
      authentication_already_taken ||
      returning_user ||
      augmented_current_user ||
      augmented_user_with_same_email ||
      new_user
    end

    private

    def authentication_already_taken
      user = adapter.find_user_with_authentication(data)
      if current_user && user && current_user != user
        Result.new(nil, Event::AUTHENTICATION_ALREADY_TAKEN)
      end
    end

    def returning_user
      user = adapter.find_user_with_authentication(data)
      Result.new(user, Event::SIGN_IN) if user
    end

    def augmented_current_user
      return nil if !current_user

      augment_user(current_user)
      Result.new(current_user, Event::TOUCHED_CURRENT_USER)
    end

    def augmented_user_with_same_email
      user = adapter.find_user_with_email(data.email)
      return if !user

      augment_user(user)
      return Result.new(user, Event::TOUCHED_EMAIL_USER)
    end

    def new_user
      user = adapter.init_user
      augment_user(user)
      Result.new(user, Event::SIGN_UP)
    end

    def augment_user(user)
      adapter.update_user_with_data_if_blank(user, data)
      adapter.update_user_with_params(user, user_params)
      adapter.build_authentication(user, data)
      user
    end
  end
end

