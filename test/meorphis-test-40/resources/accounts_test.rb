# frozen_string_literal: true

require_relative "../test_helper"

class MeorphisTest40::Test::Resources::AccountsTest < Test::Unit::TestCase
  def setup
    @meorphis_test_42 = MeorphisTest40::Client.new(base_url: "http://localhost:4010")
  end

  def test_retrieve
    response = @meorphis_test_42.accounts.retrieve("182bd5e5-6e1a-4fe4-a799-aa6d9a6ab26e")
    assert_kind_of(MeorphisTest40::Models::AccountConfiguration, response)
  end

  def test_update
    response = @meorphis_test_42.accounts.update("182bd5e5-6e1a-4fe4-a799-aa6d9a6ab26e")
    assert_kind_of(MeorphisTest40::Models::AccountConfiguration, response)
  end
end
