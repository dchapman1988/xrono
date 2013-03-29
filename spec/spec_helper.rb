# Simplecov Setup
if RUBY_VERSION >= '1.9.2'
  require 'simplecov'
  SimpleCov.start 'rails' do
    add_filter '/vendor/'
  end
end

ENV["RAILS_ENV"] ||= 'test'

require 'xrono'
require 'combustion'
Combustion.initialize!

require File.expand_path(File.dirname(__FILE__) + "/blueprints")

require 'rspec/rails'
require 'devise/test_helpers'

require 'sidekiq/testing'
require 'shoulda-matchers'
require 'database_cleaner'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
load 'spec/support/xrono/macros.rb'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

RSpec.configure do |config|
<<<<<<< HEAD
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
=======
  config.mock_with :rspec
>>>>>>> isotope11/master
  config.include Devise::TestHelpers, :type => :controller

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.before(:all)    { Sham.reset(:before_all)  }
  config.before(:each)   { Sham.reset(:before_each) }

  config.use_transactional_fixtures = true
end
