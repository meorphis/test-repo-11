# frozen_string_literal: true

module MeorphisTest40
  module Resources
    class Accounts
      # @return [MeorphisTest40::Resources::Accounts::CreditConfiguration]
      attr_reader :credit_configuration

      def initialize(client:)
        @client = client
        @credit_configuration = MeorphisTest40::Resources::Accounts::CreditConfiguration.new(client: client)
      end

      # Get account configuration such as spend limits.
      # 
      # @param account_token [String] Globally unique identifier for account.
      # @param opts [Hash|RequestOptions] Options to specify HTTP behaviour for this request.
      # 
      # @return [MeorphisTest40::Models::AccountConfiguration]
      def retrieve(account_token, opts = {})
        req = {}
        req[:method] = :get
        req[:path] = "/accounts/#{account_token}"
        req[:model] = MeorphisTest40::Models::AccountConfiguration
        @client.request(req, opts)
      end

      # Update account configuration such as spend limits and verification address. Can
      #   only be run on accounts that are part of the program managed by this API key.
      # 
      #   Accounts that are in the `PAUSED` state will not be able to transact or create
      #   new cards.
      # 
      # @param account_token [String] Globally unique identifier for account.
      # 
      # @param params [Hash] Attributes to send in this request.
      # @option params [Integer] :daily_spend_limit Amount (in cents) for the account's daily spend limit. By default the daily
      #   spend limit is set to $1,250.
      # @option params [Integer] :lifetime_spend_limit Amount (in cents) for the account's lifetime spend limit. Once this limit is
      #   reached, no transactions will be accepted on any card created for this account
      #   until the limit is updated. Note that a spend limit of 0 is effectively no
      #   limit, and should only be used to reset or remove a prior limit. Only a limit of
      #   1 or above will result in declined transactions due to checks against the
      #   account limit. This behavior differs from the daily spend limit and the monthly
      #   spend limit.
      # @option params [Integer] :monthly_spend_limit Amount (in cents) for the account's monthly spend limit. By default the monthly
      #   spend limit is set to $5,000.
      # @option params [Symbol] :state Account states.
      # @option params [VerificationAddress] :verification_address Address used during Address Verification Service (AVS) checks during
      #   transactions if enabled via Auth Rules.
      # 
      # @param opts [Hash|RequestOptions] Options to specify HTTP behaviour for this request.
      # 
      # @return [MeorphisTest40::Models::AccountConfiguration]
      def update(account_token, params = {}, opts = {})
        req = {}
        req[:method] = :patch
        req[:path] = "/accounts/#{account_token}"
        req[:body] = params
        req[:model] = MeorphisTest40::Models::AccountConfiguration
        @client.request(req, opts)
      end
    end
  end
end
