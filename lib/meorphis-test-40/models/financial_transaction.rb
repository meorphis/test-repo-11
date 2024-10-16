# frozen_string_literal: true

module MeorphisTest40
  module Models
    class FinancialTransaction < BaseModel
      # @!attribute [rw] token
      #   Globally unique identifier.
      #   @return [String]
      required :token, String

      # @!attribute [rw] category
      #   Status types:
      # * `CARD` - Issuing card transaction.
      # * `ACH` - Transaction over ACH.
      # * `TRANSFER` - Internal transfer of funds between financial accounts in your program.
      #
      #   @return [Symbol, MeorphisTest40::Models::FinancialTransaction::Category]
      required :category, enum: -> { MeorphisTest40::Models::FinancialTransaction::Category }

      # @!attribute [rw] created
      #   Date and time when the financial transaction first occurred. UTC time zone.
      #   @return [Time]
      required :created, Time

      # @!attribute [rw] currency
      #   3-digit alphabetic ISO 4217 code for the settling currency of the transaction.
      #   @return [String]
      required :currency, String

      # @!attribute [rw] descriptor
      #   A string that provides a description of the financial transaction; may be useful to display to users.
      #   @return [String]
      required :descriptor, String

      # @!attribute [rw] events
      #   A list of all financial events that have modified this financial transaction.
      #   @return [Array<MeorphisTest40::Models::FinancialTransaction::Event>]
      required :events,
               MeorphisTest40::ArrayOf.new(
                 lambda {
                   MeorphisTest40::Models::FinancialTransaction::Event
                 }
               )

      # @!attribute [rw] pending_amount
      #   Pending amount of the transaction in the currency's smallest unit (e.g., cents), including any acquirer fees.
      # The value of this field will go to zero over time once the financial transaction is settled.
      #
      #   @return [Integer]
      required :pending_amount, Integer

      # @!attribute [rw] result
      #   APPROVED transactions were successful while DECLINED transactions were declined by user, Acme, or the network.
      #   @return [Symbol, MeorphisTest40::Models::FinancialTransaction::Result]
      required :result, enum: -> { MeorphisTest40::Models::FinancialTransaction::Result }

      # @!attribute [rw] settled_amount
      #   Amount of the transaction that has been settled in the currency's smallest unit (e.g., cents), including any acquirer fees. This may change over time.
      #   @return [Integer]
      required :settled_amount, Integer

      # @!attribute [rw] status
      #   Status types:
      # * `DECLINED` - The card transaction was declined.
      # * `EXPIRED` - Acme reversed the card authorization as it has passed its expiration time.
      # * `PENDING` - Authorization is pending completion from the merchant or pending release from ACH hold period
      # * `SETTLED` - The financial transaction is completed.
      # * `VOIDED` - The merchant has voided the previously pending card authorization.
      #
      #   @return [Symbol, MeorphisTest40::Models::FinancialTransaction::Status]
      required :status, enum: -> { MeorphisTest40::Models::FinancialTransaction::Status }

      # @!attribute [rw] updated
      #   Date and time when the financial transaction was last updated. UTC time zone.
      #   @return [Time]
      required :updated, Time

      # Status types:
      # * `CARD` - Issuing card transaction.
      # * `ACH` - Transaction over ACH.
      # * `TRANSFER` - Internal transfer of funds between financial accounts in your program.
      #
      class Category < MeorphisTest40::Enum
        CARD = :CARD
        ACH = :ACH
        TRANSFER = :TRANSFER
      end

      class Event < BaseModel
        # @!attribute [rw] token
        #   Globally unique identifier.
        #   @return [String]
        optional :token, String

        # @!attribute [rw] amount
        #   Amount of the financial event that has been settled in the currency's smallest unit (e.g., cents).
        #   @return [Integer]
        optional :amount, Integer

        # @!attribute [rw] created
        #   Date and time when the financial event occurred. UTC time zone.
        #   @return [Time]
        optional :created, Time

        # @!attribute [rw] result
        #   APPROVED financial events were successful while DECLINED financial events were declined by user, Acme, or the network.
        #   @return [Symbol, MeorphisTest40::Models::FinancialTransaction::Event::Result]
        optional :result, enum: -> { MeorphisTest40::Models::FinancialTransaction::Event::Result }

        # @!attribute [rw] type
        #   Event types:
        # * `ACH_INSUFFICIENT_FUNDS` - Attempted ACH origination declined due to insufficient balance.
        # * `ACH_ORIGINATION_PENDING` - ACH origination pending release from an ACH hold.
        # * `ACH_ORIGINATION_RELEASED` - ACH origination released from pending to available balance.
        # * `ACH_RECEIPT_PENDING` - ACH receipt pending release from an ACH holder.
        # * `ACH_RECEIPT_RELEASED` - ACH receipt released from pending to available balance.
        # * `ACH_RETURN` - ACH origination returned by the Receiving Depository Financial Institution.
        # * `AUTHORIZATION` - Authorize a card transaction.
        # * `AUTHORIZATION_ADVICE` - Advice on a card transaction.
        # * `AUTHORIZATION_EXPIRY` - Card Authorization has expired and reversed by Acme.
        # * `AUTHORIZATION_REVERSAL` - Card Authorization was reversed by the merchant.
        # * `BALANCE_INQUIRY` - A card balance inquiry (typically a $0 authorization) has occurred on a card.
        # * `CLEARING` - Card Transaction is settled.
        # * `CORRECTION_DEBIT` - Manual card transaction correction (Debit).
        # * `CORRECTION_CREDIT` - Manual card transaction correction (Credit).
        # * `CREDIT_AUTHORIZATION` - A refund or credit card authorization from a merchant.
        # * `CREDIT_AUTHORIZATION_ADVICE` - A credit card authorization was approved on your behalf by the network.
        # * `FINANCIAL_AUTHORIZATION` -  A request from a merchant to debit card funds without additional clearing.
        # * `FINANCIAL_CREDIT_AUTHORIZATION` - A request from a merchant to refund or credit card funds without additional clearing.
        # * `RETURN` - A card refund has been processed on the transaction.
        # * `RETURN_REVERSAL` - A card refund has been reversed (e.g., when a merchant reverses an incorrect refund).
        # * `TRANSFER` - Successful internal transfer of funds between financial accounts.
        # * `TRANSFER_INSUFFICIENT_FUNDS` - Declined internl transfer of funds due to insufficient balance of the sender.
        #
        #   @return [Symbol, MeorphisTest40::Models::FinancialTransaction::Event::Type]
        optional :type, enum: -> { MeorphisTest40::Models::FinancialTransaction::Event::Type }

        # APPROVED financial events were successful while DECLINED financial events were declined by user, Acme, or the network.
        class Result < MeorphisTest40::Enum
          APPROVED = :APPROVED
          DECLINED = :DECLINED
        end

        # Event types:
        # * `ACH_INSUFFICIENT_FUNDS` - Attempted ACH origination declined due to insufficient balance.
        # * `ACH_ORIGINATION_PENDING` - ACH origination pending release from an ACH hold.
        # * `ACH_ORIGINATION_RELEASED` - ACH origination released from pending to available balance.
        # * `ACH_RECEIPT_PENDING` - ACH receipt pending release from an ACH holder.
        # * `ACH_RECEIPT_RELEASED` - ACH receipt released from pending to available balance.
        # * `ACH_RETURN` - ACH origination returned by the Receiving Depository Financial Institution.
        # * `AUTHORIZATION` - Authorize a card transaction.
        # * `AUTHORIZATION_ADVICE` - Advice on a card transaction.
        # * `AUTHORIZATION_EXPIRY` - Card Authorization has expired and reversed by Acme.
        # * `AUTHORIZATION_REVERSAL` - Card Authorization was reversed by the merchant.
        # * `BALANCE_INQUIRY` - A card balance inquiry (typically a $0 authorization) has occurred on a card.
        # * `CLEARING` - Card Transaction is settled.
        # * `CORRECTION_DEBIT` - Manual card transaction correction (Debit).
        # * `CORRECTION_CREDIT` - Manual card transaction correction (Credit).
        # * `CREDIT_AUTHORIZATION` - A refund or credit card authorization from a merchant.
        # * `CREDIT_AUTHORIZATION_ADVICE` - A credit card authorization was approved on your behalf by the network.
        # * `FINANCIAL_AUTHORIZATION` -  A request from a merchant to debit card funds without additional clearing.
        # * `FINANCIAL_CREDIT_AUTHORIZATION` - A request from a merchant to refund or credit card funds without additional clearing.
        # * `RETURN` - A card refund has been processed on the transaction.
        # * `RETURN_REVERSAL` - A card refund has been reversed (e.g., when a merchant reverses an incorrect refund).
        # * `TRANSFER` - Successful internal transfer of funds between financial accounts.
        # * `TRANSFER_INSUFFICIENT_FUNDS` - Declined internl transfer of funds due to insufficient balance of the sender.
        #
        class Type < MeorphisTest40::Enum
          ACH_INSUFFICIENT_FUNDS = :ACH_INSUFFICIENT_FUNDS
          ACH_ORIGINATION_PENDING = :ACH_ORIGINATION_PENDING
          ACH_ORIGINATION_RELEASED = :ACH_ORIGINATION_RELEASED
          ACH_RECEIPT_PENDING = :ACH_RECEIPT_PENDING
          ACH_RECEIPT_RELEASED = :ACH_RECEIPT_RELEASED
          ACH_RETURN = :ACH_RETURN
          AUTHORIZATION = :AUTHORIZATION
          AUTHORIZATION_ADVICE = :AUTHORIZATION_ADVICE
          AUTHORIZATION_EXPIRY = :AUTHORIZATION_EXPIRY
          AUTHORIZATION_REVERSAL = :AUTHORIZATION_REVERSAL
          BALANCE_INQUIRY = :BALANCE_INQUIRY
          CLEARING = :CLEARING
          CORRECTION_DEBIT = :CORRECTION_DEBIT
          CORRECTION_CREDIT = :CORRECTION_CREDIT
          CREDIT_AUTHORIZATION = :CREDIT_AUTHORIZATION
          CREDIT_AUTHORIZATION_ADVICE = :CREDIT_AUTHORIZATION_ADVICE
          FINANCIAL_AUTHORIZATION = :FINANCIAL_AUTHORIZATION
          FINANCIAL_CREDIT_AUTHORIZATION = :FINANCIAL_CREDIT_AUTHORIZATION
          RETURN = :RETURN
          RETURN_REVERSAL = :RETURN_REVERSAL
          TRANSFER = :TRANSFER
          TRANSFER_INSUFFICIENT_FUNDS = :TRANSFER_INSUFFICIENT_FUNDS
        end

        # @!parse
        #   # Create a new instance of Event from a Hash of raw data.
        #   #
        #   # @param data [Hash{Symbol => Object}] .
        #   #   @option data [String, nil] :token Globally unique identifier.
        #   #   @option data [Integer, nil] :amount Amount of the financial event that has been settled in the currency's smallest
        #   #     unit (e.g., cents).
        #   #   @option data [String, nil] :created Date and time when the financial event occurred. UTC time zone.
        #   #   @option data [String, nil] :result APPROVED financial events were successful while DECLINED financial events were
        #   #     declined by user, Acme, or the network.
        #   #   @option data [String, nil] :type
        #   #     Event types:
        #   #
        #   #     - `ACH_INSUFFICIENT_FUNDS` - Attempted ACH origination declined due to
        #   #       insufficient balance.
        #   #     - `ACH_ORIGINATION_PENDING` - ACH origination pending release from an ACH hold.
        #   #     - `ACH_ORIGINATION_RELEASED` - ACH origination released from pending to
        #   #       available balance.
        #   #     - `ACH_RECEIPT_PENDING` - ACH receipt pending release from an ACH holder.
        #   #     - `ACH_RECEIPT_RELEASED` - ACH receipt released from pending to available
        #   #       balance.
        #   #     - `ACH_RETURN` - ACH origination returned by the Receiving Depository Financial
        #   #       Institution.
        #   #     - `AUTHORIZATION` - Authorize a card transaction.
        #   #     - `AUTHORIZATION_ADVICE` - Advice on a card transaction.
        #   #     - `AUTHORIZATION_EXPIRY` - Card Authorization has expired and reversed by Acme.
        #   #     - `AUTHORIZATION_REVERSAL` - Card Authorization was reversed by the merchant.
        #   #     - `BALANCE_INQUIRY` - A card balance inquiry (typically a $0 authorization) has
        #   #       occurred on a card.
        #   #     - `CLEARING` - Card Transaction is settled.
        #   #     - `CORRECTION_DEBIT` - Manual card transaction correction (Debit).
        #   #     - `CORRECTION_CREDIT` - Manual card transaction correction (Credit).
        #   #     - `CREDIT_AUTHORIZATION` - A refund or credit card authorization from a
        #   #       merchant.
        #   #     - `CREDIT_AUTHORIZATION_ADVICE` - A credit card authorization was approved on
        #   #       your behalf by the network.
        #   #     - `FINANCIAL_AUTHORIZATION` - A request from a merchant to debit card funds
        #   #       without additional clearing.
        #   #     - `FINANCIAL_CREDIT_AUTHORIZATION` - A request from a merchant to refund or
        #   #       credit card funds without additional clearing.
        #   #     - `RETURN` - A card refund has been processed on the transaction.
        #   #     - `RETURN_REVERSAL` - A card refund has been reversed (e.g., when a merchant
        #   #       reverses an incorrect refund).
        #   #     - `TRANSFER` - Successful internal transfer of funds between financial accounts.
        #   #     - `TRANSFER_INSUFFICIENT_FUNDS` - Declined internl transfer of funds due to
        #   #       insufficient balance of the sender.
        #   def initialize(data = {}) = super
      end

      # APPROVED transactions were successful while DECLINED transactions were declined by user, Acme, or the network.
      class Result < MeorphisTest40::Enum
        APPROVED = :APPROVED
        DECLINED = :DECLINED
      end

      # Status types:
      # * `DECLINED` - The card transaction was declined.
      # * `EXPIRED` - Acme reversed the card authorization as it has passed its expiration time.
      # * `PENDING` - Authorization is pending completion from the merchant or pending release from ACH hold period
      # * `SETTLED` - The financial transaction is completed.
      # * `VOIDED` - The merchant has voided the previously pending card authorization.
      #
      class Status < MeorphisTest40::Enum
        DECLINED = :DECLINED
        EXPIRED = :EXPIRED
        PENDING = :PENDING
        SETTLED = :SETTLED
        VOIDED = :VOIDED
      end

      # @!parse
      #   # Create a new instance of FinancialTransaction from a Hash of raw data.
      #   #
      #   # @param data [Hash{Symbol => Object}] .
      #   #   @option data [String] :token Globally unique identifier.
      #   #   @option data [String] :category
      #   #     Status types:
      #   #
      #   #     - `CARD` - Issuing card transaction.
      #   #     - `ACH` - Transaction over ACH.
      #   #     - `TRANSFER` - Internal transfer of funds between financial accounts in your
      #   #       program.
      #   #   @option data [String] :created Date and time when the financial transaction first occurred. UTC time zone.
      #   #   @option data [String] :currency 3-digit alphabetic ISO 4217 code for the settling currency of the transaction.
      #   #   @option data [String] :descriptor A string that provides a description of the financial transaction; may be useful
      #   #     to display to users.
      #   #   @option data [Array<Object>] :events A list of all financial events that have modified this financial transaction.
      #   #   @option data [Integer] :pending_amount Pending amount of the transaction in the currency's smallest unit (e.g., cents),
      #   #     including any acquirer fees. The value of this field will go to zero over time
      #   #     once the financial transaction is settled.
      #   #   @option data [String] :result APPROVED transactions were successful while DECLINED transactions were declined
      #   #     by user, Acme, or the network.
      #   #   @option data [Integer] :settled_amount Amount of the transaction that has been settled in the currency's smallest unit
      #   #     (e.g., cents), including any acquirer fees. This may change over time.
      #   #   @option data [String] :status
      #   #     Status types:
      #   #
      #   #     - `DECLINED` - The card transaction was declined.
      #   #     - `EXPIRED` - Acme reversed the card authorization as it has passed its
      #   #       expiration time.
      #   #     - `PENDING` - Authorization is pending completion from the merchant or pending
      #   #       release from ACH hold period
      #   #     - `SETTLED` - The financial transaction is completed.
      #   #     - `VOIDED` - The merchant has voided the previously pending card authorization.
      #   #   @option data [String] :updated Date and time when the financial transaction was last updated. UTC time zone.
      #   def initialize(data = {}) = super
    end
  end
end
