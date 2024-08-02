# frozen_string_literal: true

require_relative "../test_helper"

class MeorphisTest40::Test::Resources::CardsTest < Test::Unit::TestCase
  def setup
    @meorphis_test_40 = MeorphisTest40::Client.new(base_url: "http://localhost:4010")
  end

  def test_create_required_params
    response = @meorphis_test_40.cards.create({type: "VIRTUAL"})
    assert_kind_of(MeorphisTest40::Models::Card, response)
  end

  def test_retrieve
    response = @meorphis_test_40.cards.retrieve("182bd5e5-6e1a-4fe4-a799-aa6d9a6ab26e")
    assert_kind_of(MeorphisTest40::Models::Card, response)
  end

  def test_update
    response = @meorphis_test_40.cards.update("182bd5e5-6e1a-4fe4-a799-aa6d9a6ab26e")
    assert_kind_of(MeorphisTest40::Models::Card, response)
  end

  def test_provision
    response = @meorphis_test_40.cards.provision("182bd5e5-6e1a-4fe4-a799-aa6d9a6ab26e")
    assert_kind_of(MeorphisTest40::Models::CardProvisionResponse, response)
  end
end
