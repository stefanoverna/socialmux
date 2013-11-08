require 'spec_helper'

module Socialmux::AuthMapper
  describe GoogleOauth2 do
    subject do
      GoogleOauth2.new(read_json('google_response'))
    end

    its(:uid) { should eq "106136318376168001814" }
    its(:provider) { should eq "google_oauth2" }
    its(:first_name) { should eq "Stefano" }
    its(:last_name) { should eq "Verna" }
    its(:email) { should eq "stefano.verna@gmail.com" }
    its(:image) { should eq "https://lh3.googleusercontent.com/-Mk9Xg5Qy_vc/AAAAAAAAAAI/AAAAAAAAAK4/h0ffVEFGrTo/photo.jpg" }
    its(:url) { should be_nil }
    its(:gender) { should eq Gender::MALE }
  end
end

