require 'spec_helper'

module Socialmux::AuthMapper
  describe Facebook do
    subject do
      Facebook.new(read_json('facebook_response'))
    end

    its(:uid) { should eq "771417286" }
    its(:provider) { should eq "facebook" }
    its(:first_name) { should eq "Stefano" }
    its(:last_name) { should eq "Verna" }
    its(:email) { should eq "stefano.verna@welaika.com" }
    its(:image) { should eq "http://graph.facebook.com/771417286/picture?type=square" }
    its(:url) { should eq "https://www.facebook.com/stefano.verna" }
    its(:gender) { should eq Gender::MALE }
  end
end


