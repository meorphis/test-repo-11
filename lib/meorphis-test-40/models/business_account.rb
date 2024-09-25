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
      end
    end
  end
end
