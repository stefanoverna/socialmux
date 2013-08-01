module Socialmux
  module Event
    SIGN_IN = :sign_in
    SIGN_UP = :sign_up
    TOUCHED_CURRENT_USER = :updated_current_user
    TOUCHED_EMAIL_USER = :updated_email_user

    def self.all
      [ SIGN_IN, SIGN_UP, TOUCHED_CURRENT_USER, TOUCHED_EMAIL_USER ]
    end
  end
end

