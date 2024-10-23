# frozen_string_literal: true

module MeorphisTest40
  module Resources
    class Accounts
      class CreditConfiguration
        # @param client [MeorphisTest40::Client]
        def initialize(client:)
          @client = client
        end

        # Get an Account's credit configuration
        #
        # @param account_token [String] Globally unique identifier for account.
        # @param opts [Hash, MeorphisTest40::RequestOptions] Options to specify HTTP behaviour for this request.
        #
        # @return [MeorphisTest40::Models::BusinessAccount]
        def retrieve(account_token, opts = {})
          req = {
            method: :get,
            path: "/accounts/#{account_token}/credit_configuration",
            model: MeorphisTest40::Models::BusinessAccount
          }
          @client.request(req, opts)
        end

        # Update a Business Accounts credit configuration
        #
        # @param account_token [String] Globally unique identifier for account.
        #
        # @param params [Hash] Attributes to send in this request.
        #   @option params [Integer, nil] :billing_period Number of days within the billing period
        #   @option params [Integer, nil] :credit_limit Credit limit extended to the Business Account
        #   @option params [String, nil] :external_bank_account_token The external bank account token to use for auto-collections
        #   @option params [Integer, nil] :payment_period Number of days after the billing period ends that a payment is required
        #
        # @param opts [Hash, MeorphisTest40::RequestOptions] Options to specify HTTP behaviour for this request.
        #
        # @return [MeorphisTest40::Models::BusinessAccount]
        def update(account_token, params = {}, opts = {})
          req = {
            method: :patch,
            path: "/accounts/#{account_token}/credit_configuration",
            body: params,
            headers: {"Content-Type" => "application/json"},
            model: MeorphisTest40::Models::BusinessAccount
          }
          @client.request(req, opts)
        end
      end
    end
  end
end
