require 'spec_helper'

module Socialmux
  describe Result do
    let (:user) { stub('User') }

    subject do
      Result.new(user, Event::SIGN_UP)
    end

    it "implements dynamic boolean methods for events" do
      expect(subject.sign_up?).to be_truthy
      expect(subject.sign_in?).to be_falsy
    end
  end
end

