# frozen_string_literal: true

require_relative "../test_helper"

class MeorphisTest40::Test::Resources::StatusTest < Test::Unit::TestCase
  def setup
    @meorphis_test_40 = MeorphisTest40::Client.new(base_url: "http://localhost:4010")
  end

  def test_list
    response = @meorphis_test_40.status.list
    assert_kind_of(MeorphisTest40::Models::StatusListResponse, response)
  end
end
