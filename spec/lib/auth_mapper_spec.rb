require 'spec_helper'

module Socialmux
  describe AuthMapper do
    describe ".init_with_data" do
      it "dinamically finds the mapper class and instanciates it" do
        data = { provider: 'facebook' }
        mapper = AuthMapper.init_with_data(data)
        expect(mapper).to be_a AuthMapper::Facebook
      end

      it "raises NotFound if not found" do
        data = { provider: 'foobar' }
        expect do
          AuthMapper.init_with_data(data)
        end.to raise_error AuthMapper::NotFound
      end
    end
  end
end

