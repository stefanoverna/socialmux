# encoding: utf-8

require 'spec_helper'

module Socialmux::AuthMapper
  describe Twitter do
    subject do
      Twitter.new(read_json('twitter_response'))
    end

    its(:uid) { should eq "5521662" }
    its(:provider) { should eq "twitter" }
    its(:first_name) { should eq "Stefano" }
    its(:last_name) { should eq "Verna" }
    its(:email) { should be nil }
    its(:image) { should eq "http://a0.twimg.com/profile_images/3060238387/a9b2a4cd85377cf0c12b22fedcac80b3_normal.png" }
    its(:description) { should eq "28 years, 2 babies, Rails and iOS developer, cofounder of @weLaika. Tweet me anytime! ♥" }
  end
end



