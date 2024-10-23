# frozen_string_literal: true

module MeorphisTest40
  module Models
    class CardProvisionResponse < BaseModel
      # @!attribute [rw] provisioning_payload
      #   @return [String]
      optional :provisioning_payload, String

      # @!parse
      #   # Create a new instance of CardProvisionResponse from a Hash of raw data.
      #   #
      #   # @param data [Hash{Symbol => Object}] .
      #   #   @option data [String, nil] :provisioning_payload
      #   def initialize(data = {}) = super
    end
  end
end
