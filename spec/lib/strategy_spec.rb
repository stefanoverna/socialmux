require 'spec_helper'

module Socialmux
  describe Strategy do
    let(:current_user) { nil }
    let(:adapter) { stub('SchemaAdapter') }
    let(:user) { stub('User') }
    let(:mapper) { stub('Social::AuthMapper::Base', email: 'email') }
    let(:user_params) { stub('params') }

    let(:strategy) do
      Strategy.new(
        current_user: current_user,
        adapter: adapter,
        data: mapper,
        user_params: user_params
      )
    end
    subject { strategy }

    before do
      strategy.stubs(:data).returns(mapper)
    end

    describe ".result" do
      subject { strategy.result }

      before do
        strategy.stubs(:augment_user)
      end

      context 'previous authentication is found, but linked to a user different than the one currently signed in' do
        let(:current_user) { user }
        let(:another_user) { stub('User') }

        before do
          adapter.stubs(:find_user_with_authentication).with(mapper).returns(another_user)
        end

        its(:user) { should be_nil }
        its(:event) { should eq Event::AUTHENTICATION_ALREADY_TAKEN }
      end

      context "previous authentication is found" do
        let(:current_user) { nil }

        before do
          adapter.stubs(:find_user_with_authentication).with(mapper).returns(user)
        end

        its(:user) { should eq user }
        its(:event) { should eq Event::SIGN_IN }
      end

      context "current_user is present" do
        let(:current_user) { user }

        before do
          adapter.stubs(:find_user_with_authentication).returns(nil)
          strategy.result
        end

        its(:user) { should eq user }
        its(:event) { should eq Event::TOUCHED_CURRENT_USER }

        it "should augment the current user" do
          expect(strategy).to have_received(:augment_user).with(user)
        end
      end

      context "user with same email is present" do
        before do
          adapter.stubs(:find_user_with_authentication).returns(nil)
          adapter.stubs(:find_user_with_email).with("email").returns(user)
          strategy.result
        end

        its(:user) { should eq user }
        its(:event) { should eq Event::TOUCHED_EMAIL_USER }

        it "should augment the found user" do
          expect(strategy).to have_received(:augment_user).with(user)
        end
      end

      context "none of the above" do
        before do
          adapter.stubs(:init_user).returns(user)
          adapter.stubs(:find_user_with_authentication).returns(nil)
          adapter.stubs(:find_user_with_email).returns(nil)
          strategy.result
        end

        its(:user) { should eq user }
        its(:event) { should eq Event::SIGN_UP }

        it "should augment the newly created user" do
          expect(strategy).to have_received(:augment_user).with(user)
        end
      end
    end

    describe "augment_user" do
      before do
        adapter.stubs(:update_user_with_data_if_blank)
        adapter.stubs(:update_user_with_params)
        adapter.stubs(:build_authentication)
        strategy.send(:augment_user, user)
      end

      it "should call update_user_with_data_if_blank on the scheme adapter" do
        expect(adapter).to have_received(:update_user_with_data_if_blank).with(user, mapper)
      end

      it "should call update_user_with_params on the scheme adapter" do
        expect(adapter).to have_received(:update_user_with_params).with(user, user_params)
      end

      it "should call build_authentication on the scheme adapter" do
        expect(adapter).to have_received(:build_authentication).with(user, mapper)
      end
    end
  end
end

