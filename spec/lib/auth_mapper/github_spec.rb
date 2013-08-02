require 'spec_helper'

module Socialmux::AuthMapper
  describe Github do
    subject do
      Github.new(read_json('github_response'))
    end

    its(:uid) { should eq "51573" }
    its(:provider) { should eq "github" }
    its(:first_name) { should eq "Stefano" }
    its(:last_name) { should eq "Verna" }
    its(:email) { should eq "stefano.verna@gmail.com" }
    its(:image) { should eq "https://secure.gravatar.com/avatar/f1b1c16a5b246b3b7cff8d8a07aa9725?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png" }
    its(:url) { should eq "https://github.com/stefanoverna" }
    its(:gender) { should be_nil }
  end
end


