# frozen_string_literal: true

module MeorphisTest40
  module Resources
    class Accounts
      class CreditConfiguration
        def initialize(client:)
          @client = client
        end

        # Get an Account's credit configuration
        # 
        # @param account_token [String] Globally unique identifier for account.
        # @param opts [Hash|RequestOptions] Options to specify HTTP behaviour for this request.
        # 
        # @return [MeorphisTest40::Models::BusinessAccount]
        def retrieve(account_token, opts = {})
          req = {}
          req[:method] = :get
          req[:path] = "/accounts/#{account_token}/credit_configuration"
          req[:model] = MeorphisTest40::Models::BusinessAccount
          @client.request(req, opts)
        end

        # Update a Business Accounts credit configuration
        # 
        # @param account_token [String] Globally unique identifier for account.
        # 
        # @param params [Hash] Attributes to send in this request.
        # @option params [Integer] :billing_period Number of days within the billing period
        # @option params [Integer] :credit_limit Credit limit extended to the Business Account
        # @option params [String] :external_bank_account_token The external bank account token to use for auto-collections
        # @option params [Integer] :payment_period Number of days after the billing period ends that a payment is required
        # 
        # @param opts [Hash|RequestOptions] Options to specify HTTP behaviour for this request.
        # 
        # @return [MeorphisTest40::Models::BusinessAccount]
        def update(account_token, params = {}, opts = {})
          req = {}
          req[:method] = :patch
          req[:path] = "/accounts/#{account_token}/credit_configuration"
          req[:body] = params
          req[:model] = MeorphisTest40::Models::BusinessAccount
          @client.request(req, opts)
        end
      end
    end
  end
end
