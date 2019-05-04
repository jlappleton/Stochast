require 'simplecov'
SimpleCov.start do
  add_filter "/test/"
  add_filter "/spec/"
  add_filter "/initializers/"
  add_filter "environment.rb"
  add_filter "/environments/"
end
require 'minitest/autorun'
SimpleCov.command_name "Minitest"
require 'codecov'
SimpleCov.formatters = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov.formatter = SimpleCov::Formatter::Codecov,
  ])
  
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
