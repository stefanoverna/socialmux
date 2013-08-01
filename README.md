# Socialmux

Socialmux implements a strategy to add multiple social providers to the same
user. It's meant to be used togheter with OmniAuth.

* Socialmux works with any DB schema and ORM, as it delegates DB management to 
a simple adapter class the developer needs to implement.

* Socialmux works with any authentication system, as it just prepares the User
  model, and leave the authentication part to your controllers.

## The strategy

* If a matching social account is already present in the database:
  * it returns the linked user and no change is made;

* If a user is already signed in:
   * it fills up any user blank attribute with data coming from the
     authentication;
   * it builds a new social authentication model, and adds it to the user model;
   * it returns the modified user without saving it;

* If an user exists with the same email:
   * it fills up any user blank attribute with data coming from the
     authentication;
   * it builds a new social authentication model, and adds it to the user model;
   * it returns the modified user without saving it;

* Otherwise a new User instance gets instantiated:
   * it fills up any user blank attribute with data coming from the
     authentication;
   * it builds a new social authentication model, and adds it to the user model;
   * it returns the modified user without saving it;

## Installation

Add this line to your application's Gemfile:

    gem 'socialmux'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install socialmux

## Typical Usage

This is a real word example for the following schema:

* `User (email, password)`
* `Profile (user_id, first_name, last_name, bio)`
* `SocialAuth (user_id, provider, uid, raw_data)`

User requires an email, so if an external auth provider does not give us this 
information, a form will be shown for the user to fill it in.

### `config/routes.rb`

```ruby
MyApp::Application.routes.draw do
  devise_for :users

  # OmniAuth route
  match '/auth/:provider/callback' => 'social#callback', via: [:get, :post]

  # This is where the magic happens :)
  match '/auth/complete' => 'social#complete', as: :social_complete, via: [:get, :post], as: :social_complete

  # ...
end
```

### `app/services/social_schema_adapter.rb`

This is the adapter to the database. Socialmux requires these methods'
interfaces. The implementation will differ based on the project.

```ruby
class SocialSchemaAdapter
  def init_user
    User.new
  end

  def find_user_with_email(email)
    User.where(email: email).first
  end

  def find_user_with_authentication(data)
    auth = SocialAuth.where(provider: data.provider, uid: data.uid).first
    auth.user if auth.present?
  end

  def update_user_with_params(user, user_params)
    user.attributes = user_params
  end

  def update_user_with_data_if_blank(user, data)
    profile = user.profile || user.build_profile

    update_attr_if_blank(user, :email, data.email)
    update_attr_if_blank(profile, :first_name, data.first_name)
    update_attr_if_blank(profile, :last_name, data.last_name)
    update_attr_if_blank(profile, :bio, data.description)
  end

  def build_authentication(user, data)
    auth_attrs = { provider: data.provider, uid: data.uid, raw_data: data.info.to_hash }
    user.social_auths.build(auth_attrs)
  end

  private

  def update_attr_if_blank(record, key, value)
    current_value = record.send(key)
    record.send("#{key}=", value) if current_value.blank?
  end
end
```

### `app/controllers/social_controller.rb`

```ruby
  class SocialController < ApplicationController
    def callback
      session[:omniauth] ||= request.env['omniauth.auth']
      redirect_to social_complete_path
    end

    def complete

      # Here we instanciate our Socialmux strategy with all the required
      # arguments

      authentication = Socialmux::Strategy.new(
        adapter: SocialSchemaAdapter.new,
        current_user: current_user,
        omniauth_data: session[:omniauth],
        user_params: user_params
      )

      # `.result` returns a Socialmux::Result, which gives us the
      # found/generated user that we need to sign in
      result = authentication.result
      @user = result.user

      # If you cannot save the model, it's because some required fields
      # could not be extracted from the thirdy party authentication source.
      # We render a form that points to this very same action.

      if @user.save
        sign_in_and_notice(@user, result.event)
      else
        render :complete
      end
    end

    private

    def user_params
      if request.post?
        params.require(:user).permit(:email, profile_attributes: [ :first_name, :last_name, :bio ])
      else
        {}
      end
    end

    def sign_in_and_notice(user, event)
      flash[:notice] = "Result: #{event}"
      session.delete(:omniauth)
      sign_in_and_redirect(user)
    end
  end
```

### `app/views/social/complete.html.slim`

```slim
h1 Sign up with Social

= simple_form_for @user, url: social_complete_path do |f|

  p You're close to finish the registration process... In order to be able to restore your account in the future, please insert your email!

  = f.input :email

  fieldset
    legend Optional data

    = f.simple_fields_for :profile do |p|
      = p.input :first_name
      = p.input :last_name
      = p.input :bio

  = f.button :submit
```

## About sessions

In the above example, OmniAuth `AuthResult` is stored in session until the user
completes the sign up process.

If you use cookies, this won't work and raise a `CookieOverflow` error. Use a
session store backed by an Active Record class:

```ruby
gem 'activerecord-session_store', github: 'rails/activerecord-session_store'
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

