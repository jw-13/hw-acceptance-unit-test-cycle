require 'simplecov'
SimpleCov.start 'rails'

RSpec.describe MoviesHelper do
  include MoviesHelper
  context "whatever you want" do
      it "whatever you want" do
        expect(oddness(2)).to eq("even")
      end
     it "whatever you want" do
        expect(oddness(3)).to eq("odd")
      end
  end
end
