require 'spec_helper'

module Socialmux::AuthMapper
  describe Linkedin do
    subject do
      Linkedin.new(read_json('linkedin_response'))
    end

    its(:uid) { should eq "yCmV0Ms_fg" }
    its(:provider) { should eq "linkedin" }
    its(:first_name) { should eq "Stefano" }
    its(:last_name) { should eq "Verna" }
    its(:email) { should eq "stefano.verna@gmail.com" }
    its(:image) { should eq "http://m.c.lnkd.licdn.com/mpr/mprx/0_dCvykIIfOoeQZqWUdXQ_keMhpEuE4-4UIhTikeHriWZsFnfR5k5KoHyO-G2vUzJBHTBCwfsBBN4N" }
    its(:description) { should eq "Software Engineer at weLaika" }
  end
end



