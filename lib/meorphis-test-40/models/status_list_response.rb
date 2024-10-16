# frozen_string_literal: true

module MeorphisTest40
  module Models
    class StatusListResponse < BaseModel
      # @!attribute [rw] message
      #   @return [String]
      optional :message, String

      # @!parse
      #   # Create a new instance of StatusListResponse from a Hash of raw data.
      #   #
      #   # @param data [Hash{Symbol => Object}] .
      #   #   @option data [String, nil] :message
      #   def initialize(data = {}) = super
    end
  end
end
