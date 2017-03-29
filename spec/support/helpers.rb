Dir[Rails.root.join('spec/support/helpers/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.include Features::SessionHelpers, type: :feature
  config.include ActiveSupport::Testing::TimeHelpers
end
