require 'coveralls'
Coveralls.wear!

require 'rubygems'
require 'bundler'
require 'socialmux'

# add project root to load path
ROOT = File.expand_path('../..', __FILE__)
require File.join(ROOT, "spec/support/rspec_config.rb")
require File.join(ROOT, "spec/support/fixture_helpers.rb")

