require 'json'

module FixtureHelpers
  def read_json(name)
    fixture_path = File.join(ROOT, "spec/fixtures", "#{name}.json")
    JSON.parse File.new(fixture_path).read
  end
end

RSpec.configure do |config|
  config.include FixtureHelpers
end

