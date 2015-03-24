ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rspec'
require 'capybara/rails'
require 'pundit/rspec'




# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|

  config.infer_spec_type_from_file_location!


  config.include Warden::Test::Helpers
  config.before :suite do
    Warden.test_mode!
  end

  # Only run tests that is tagget with focus.
  # describe "something", :focus => true do
  config.filter_run :focus => true
  # Run all tests when no tests is tagged.
  config.run_all_when_everything_filtered = true

  config.include RSpec::Rails::RequestExampleGroup, type: :request, example_group: {
    file_path: /spec\/api/
  }
  config.include Devise::TestHelpers, type: :controller


  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"


  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  # include feature helper
  config.include FeatureHelper, type: :feature

  def api_key
    @api_key ||= Fabricate :api_key
  end

  def https_and_authorization(key = api_key)
    { 'HTTPS' => 'on', "HTTP_AUTHORIZATION" => key.access_token }
  end
end
