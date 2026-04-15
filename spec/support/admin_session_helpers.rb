# frozen_string_literal: true

module AdminSessionHelpers
  def sign_in_as_admin(admin = nil)
    admin ||= create(:admin)

    login_as(admin, scope: :admin)
  end
end

RSpec.configure do |config|
  config.include Warden::Test::Helpers, type: :system
  config.include AdminSessionHelpers, type: :system

  config.before(:suite) do
    Warden.test_mode!
  end

  config.after(:each, type: :system) do
    Warden.test_reset!
  end
end
