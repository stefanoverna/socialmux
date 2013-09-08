# encoding: utf-8

require 'spec_helper'

module Socialmux::AuthMapper
  describe Twitter do
    subject do
      Instagram.new(read_json('instagram_response'))
    end

    its(:uid) { should eq "15075543" }
    its(:provider) { should eq "instagram" }
    its(:first_name) { should eq "Stefano" }
    its(:last_name) { should eq "Verna" }
    its(:email) { should be nil }
    its(:image) { should eq "http://images.ak.instagram.com/profiles/anonymousUser.jpg" }
    its(:description) { should eq "Foobar" }
    its(:url) { should eq "http://instagram.com/steffoz" }
    its(:gender) { should be_nil }
  end
end

