# frozen_string_literal: true

module MeorphisTest40
  module Resources
    class Cards
      class FinancialTransactions
        def initialize(client:)
          @client = client
        end

        # Get the card financial transaction for the provided token.
        # 
        # @param card_token [String]
        # @param financial_transaction_token [String] Globally unique identifier for financial transaction token.
        # @param opts [Hash|RequestOptions] Options to specify HTTP behaviour for this request.
        # 
        # @return [MeorphisTest40::Models::FinancialTransaction]
        def retrieve(card_token, financial_transaction_token, opts = {})
          req = {}
          req[:method] = :get
          req[:path] = "/cards/#{card_token}/financial_transactions/#{financial_transaction_token}"
          req[:model] = MeorphisTest40::Models::FinancialTransaction
          @client.request(req, opts)
        end
      end
    end
  end
end
