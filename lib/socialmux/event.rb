module Socialmux
  module Event
    SIGN_IN = :sign_in
    SIGN_UP = :sign_up
    TOUCHED_CURRENT_USER = :updated_current_user
    TOUCHED_EMAIL_USER = :updated_email_user
    AUTHENTICATION_ALREADY_TAKEN = :authentication_already_taken

    def self.all
      [
        SIGN_IN,
        SIGN_UP,
        TOUCHED_CURRENT_USER,
        TOUCHED_EMAIL_USER,
        AUTHENTICATION_ALREADY_TAKEN
      ]
    end
  end
end

