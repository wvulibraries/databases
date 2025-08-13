# --- SimpleCov must load first ---
require 'simplecov'
require 'simplecov-lcov'
require 'simplecov-console'

SimpleCov::Formatter::LcovFormatter.config do |c|
  c.report_with_single_file = true
  c.output_directory = 'coverage'
  c.lcov_file_name = 'lcov.info'
end

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::LcovFormatter,   # writes coverage/lcov.info
  SimpleCov::Formatter::Console          # prints summary to CI logs
])

SimpleCov.start do
  add_filter %r{^/spec/}
  add_filter %r{^/bin/}
  add_filter %r{^/config/}
  add_filter 'app/controllers/public/connect_controller.rb'
  add_filter 'app/controllers/concerns/authenticatable.rb'
  add_filter 'app/helpers/authentication_helper.rb'
end




require "rack_session_access/capybara"
require 'capybara/rspec'

ENV['RAILS_ENV'] ||= 'test'

RSpec.configure do |config|
  # config expectations
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # config mocks
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  # alternative configs
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.default_formatter = 'doc'
  config.order = :random
end

