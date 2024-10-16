# frozen_string_literal: true

require_relative "../test_helper"

class MeorphisTest40::Test::Resources::AccountsTest < Minitest::Test
  parallelize_me!

  def setup
    @meorphis_test_46 = MeorphisTest40::Client.new(base_url: ENV.fetch("TEST_API_BASE_URL", "http://localhost:4010"))
  end

  def test_retrieve
    response = @meorphis_test_46.accounts.retrieve("182bd5e5-6e1a-4fe4-a799-aa6d9a6ab26e")
    assert_kind_of(MeorphisTest40::Models::AccountConfiguration, response)
  end

  def test_update
    response = @meorphis_test_46.accounts.update("182bd5e5-6e1a-4fe4-a799-aa6d9a6ab26e")
    assert_kind_of(MeorphisTest40::Models::AccountConfiguration, response)
  end
end
