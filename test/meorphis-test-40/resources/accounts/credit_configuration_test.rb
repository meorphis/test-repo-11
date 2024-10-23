# frozen_string_literal: true

require_relative "../../test_helper"

class MeorphisTest40::Test::Resources::Accounts::CreditConfigurationTest < Minitest::Test
  parallelize_me!

  def setup
    @meorphis_test_46 = MeorphisTest40::Client.new(base_url: ENV.fetch("TEST_API_BASE_URL", "http://localhost:4010"))
  end

  def test_retrieve
    response = @meorphis_test_46.accounts.credit_configuration.retrieve("182bd5e5-6e1a-4fe4-a799-aa6d9a6ab26e")
    assert_kind_of(MeorphisTest40::Models::BusinessAccount, response)
  end

  def test_update
    response = @meorphis_test_46.accounts.credit_configuration.update("182bd5e5-6e1a-4fe4-a799-aa6d9a6ab26e")
    assert_kind_of(MeorphisTest40::Models::BusinessAccount, response)
  end
end