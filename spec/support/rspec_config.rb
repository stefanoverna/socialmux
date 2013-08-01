require 'bourne'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.mock_with :mocha
  config.order = "random"
  config.fail_fast = true
end

