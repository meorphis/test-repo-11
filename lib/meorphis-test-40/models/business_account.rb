# frozen_string_literal: true

module MeorphisTest40
  module Models
    class BusinessAccount < BaseModel
      # @!attribute [rw] token
      #   Account token
      #   @return [String]
      required :token, String

      # @!attribute [rw] collections_configuration
      #   @return [MeorphisTest40::Models::BusinessAccount::CollectionsConfiguration]
      optional :collections_configuration,
               -> { MeorphisTest40::Models::BusinessAccount::CollectionsConfiguration }

      # @!attribute [rw] credit_limit
      #   Credit limit extended to the Account
      #   @return [Integer]
      optional :credit_limit, Integer

      class CollectionsConfiguration < BaseModel
        # @!attribute [rw] billing_period
        #   Number of days within the billing period
        #   @return [Integer]
        required :billing_period, Integer

        # @!attribute [rw] payment_period
        #   Number of days after the billing period ends that a payment is required
        #   @return [Integer]
        required :payment_period, Integer

        # @!attribute [rw] external_bank_account_token
        #   The external bank account token to use for auto-collections
        #   @return [String]
        optional :external_bank_account_token, String

        # @!parse
        #   # Create a new instance of CollectionsConfiguration from a Hash of raw data.
        #   #
        #   # @param data [Hash{Symbol => Object}] .
        #   #   @option data [Integer] :billing_period Number of days within the billing period
        #   #   @option data [Integer] :payment_period Number of days after the billing period ends that a payment is required
        #   #   @option data [String, nil] :external_bank_account_token The external bank account token to use for auto-collections
        #   def initialize(data = {}) = super
      end

      # @!parse
      #   # Create a new instance of BusinessAccount from a Hash of raw data.
      #   #
      #   # @param data [Hash{Symbol => Object}] .
      #   #   @option data [String] :token Account token
      #   #   @option data [Object, nil] :collections_configuration
      #   #   @option data [Integer, nil] :credit_limit Credit limit extended to the Account
      #   def initialize(data = {}) = super
    end
  end
end
