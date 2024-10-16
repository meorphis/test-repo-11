# frozen_string_literal: true

require_relative "../test_helper"

class MeorphisTest40::Test::Resources::StatusTest < Minitest::Test
  parallelize_me!

  def setup
    @meorphis_test_46 = MeorphisTest40::Client.new(base_url: ENV.fetch("TEST_API_BASE_URL", "http://localhost:4010"))
  end

  def test_list
    response = @meorphis_test_46.status.list
    assert_kind_of(MeorphisTest40::Models::StatusListResponse, response)
  end
end
