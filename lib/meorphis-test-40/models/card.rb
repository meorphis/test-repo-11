# frozen_string_literal: true

module MeorphisTest40
  module Models
    class Card < BaseModel
      # @!attribute [rw] token
      #   Globally unique identifier.
      #   @return [String]
      required :token, String

      # @!attribute [rw] created
      #   An RFC 3339 timestamp for when the card was created. UTC time zone.
      #   @return [String]
      required :created, String

      # @!attribute [rw] funding
      #   @return [MeorphisTest40::Models::Card::Funding]
      required :funding, -> { MeorphisTest40::Models::Card::Funding }

      # @!attribute [rw] last_four
      #   Last four digits of the card number.
      #   @return [String]
      required :last_four, String

      # @!attribute [rw] spend_limit
      #   Amount (in cents) to limit approved authorizations. Transaction requests above the spend limit will be declined.
      #   @return [Integer]
      required :spend_limit, Integer

      # @!attribute [rw] spend_limit_duration
      #   Spend limit duration values:
      # * `ANNUALLY` - Card will authorize transactions up to spend limit in a calendar year.
      # * `FOREVER` - Card will authorize only up to spend limit for the entire lifetime of the card.
      # * `MONTHLY` - Card will authorize transactions up to spend limit for the trailing month. Month is calculated as this calendar date one month prior.
      # * `TRANSACTION` - Card will authorize multiple transactions if each individual transaction is under the spend limit.
      #
      #   @return [Symbol]
      required :spend_limit_duration, MeorphisTest40::Enum.new(:ANNUALLY, :FOREVER, :MONTHLY, :TRANSACTION)

      # @!attribute [rw] state
      #   Card state values:
      # * `CLOSED` - Card will no longer approve authorizations. Closing a card cannot be undone.
      # * `OPEN` - Card will approve authorizations (if they match card and account parameters).
      # * `PAUSED` - Card will decline authorizations, but can be resumed at a later time.
      # * `PENDING_FULFILLMENT` - The initial state for cards of type `PHYSICAL`. The card is provisioned pending manufacturing and fulfillment. Cards in this state can accept authorizations for e-commerce purchases, but not for "Card Present" purchases where the physical card itself is present.
      # * `PENDING_ACTIVATION` - Each business day at 2pm Eastern Time Zone (ET), cards of type `PHYSICAL` in state `PENDING_FULFILLMENT` are sent to the card production warehouse and updated to state `PENDING_ACTIVATION` . Similar to `PENDING_FULFILLMENT`, cards in this state can be used for e-commerce transactions. API clients should update the card's state to `OPEN` only after the cardholder confirms receipt of the card.
      # 
      # In sandbox, the same daily batch fulfillment occurs, but no cards are actually manufactured.
      #
      #   @return [Symbol]
      required :state,
               MeorphisTest40::Enum.new(:CLOSED, :OPEN, :PAUSED, :PENDING_ACTIVATION, :PENDING_FULFILLMENT)

      # @!attribute [rw] type
      #   Card types:
      # * `VIRTUAL` - Card will authorize at any merchant and can be added to a digital wallet like Apple Pay or Google Pay (if the card program is digital wallet-enabled).
      # * `PHYSICAL` - Manufactured and sent to the cardholder. We offer white label branding, credit, ATM, PIN debit, chip/EMV, NFC and magstripe functionality. Reach out at [acme.com/contact](https://acme.com/contact) for more information.
      # * `SINGLE_USE` - Card is closed upon first successful authorization.
      # * `MERCHANT_LOCKED` - *[Deprecated]* Card is locked to the first merchant that successfully authorizes the card.
      #
      #   @return [Symbol]
      required :type, MeorphisTest40::Enum.new(:VIRTUAL, :PHYSICAL, :MERCHANT_LOCKED, :SINGLE_USE)

      # @!attribute [rw] auth_rule_tokens
      #   List of identifiers for the Auth Rule(s) that are applied on the card.
      #
      #   @return [Array<String>]
      optional :auth_rule_tokens, MeorphisTest40::ArrayOf.new(String)

      # @!attribute [rw] cvv
      #   Three digit cvv printed on the back of the card.
      #   @return [String]
      optional :cvv, String

      # @!attribute [rw] digital_card_art_token
      #   Specifies the digital card art to be displayed in the user’s digital wallet after tokenization. This artwork must be approved by Mastercard and configured by Acme to use. See [Flexible Card Art Guide](https://docs.acme.com/docs/about-digital-wallets#flexible-card-art).
      #   @return [String]
      optional :digital_card_art_token, String

      # @!attribute [rw] exp_month
      #   Two digit (MM) expiry month.
      #   @return [String]
      optional :exp_month, String

      # @!attribute [rw] exp_year
      #   Four digit (yyyy) expiry year.
      #   @return [String]
      optional :exp_year, String

      # @!attribute [rw] hostname
      #   Hostname of card’s locked merchant (will be empty if not applicable).
      #   @return [String]
      optional :hostname, String

      # @!attribute [rw] memo
      #   Friendly name to identify the card. We recommend against using this field to store JSON data as it can cause unexpected behavior.
      #   @return [String]
      optional :memo, String

      # @!attribute [rw] pan
      #   Primary Account Number (PAN) (i.e. the card number). Customers must be PCI compliant to have PAN returned as a field in production. Please contact [support@acme.com](mailto:support@acme.com) for questions.
      #
      #   @return [String]
      optional :pan, String

      class Funding < BaseModel
        # @!attribute [rw] token
        #   A globally unique identifier for this FundingAccount.
        #   @return [String]
        required :token, String

        # @!attribute [rw] created
        #   An RFC 3339 string representing when this funding source was added to the Acme account. This may be `null`. UTC time zone.
        #   @return [String]
        required :created, String

        # @!attribute [rw] last_four
        #   The last 4 digits of the account (e.g. bank account, debit card) associated with this FundingAccount. This may be null.
        #   @return [String]
        required :last_four, String

        # @!attribute [rw] state
        #   State of funding source.
        # 
        # Funding source states:
        # * `ENABLED` - The funding account is available to use for card creation and transactions.
        # * `PENDING` - The funding account is still being verified e.g. bank micro-deposits verification.
        # * `DELETED` - The founding account has been deleted.
        #
        #   @return [Symbol]
        required :state, MeorphisTest40::Enum.new(:ENABLED, :PENDING, :DELETED)

        # @!attribute [rw] type
        #   Types of funding source:
        # * `DEPOSITORY_CHECKING` - Bank checking account.
        # * `DEPOSITORY_SAVINGS` - Bank savings account.
        #
        #   @return [Symbol]
        required :type, MeorphisTest40::Enum.new(:DEPOSITORY_CHECKING, :DEPOSITORY_SAVINGS)

        # @!attribute [rw] account_name
        #   Account name identifying the funding source. This may be `null`.
        #   @return [String]
        optional :account_name, String

        # @!attribute [rw] nickname
        #   The nickname given to the `FundingAccount` or `null` if it has no nickname.
        #   @return [String]
        optional :nickname, String
      end
    end
  end
end
