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
      #   @return [DateTime]
      required :created, DateTime

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
      #   One of the constants defined in {MeorphisTest40::Models::Card::SpendLimitDuration}
      #   @return [Symbol]
      required :spend_limit_duration, enum: -> { MeorphisTest40::Models::Card::SpendLimitDuration }

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
      #   One of the constants defined in {MeorphisTest40::Models::Card::State}
      #   @return [Symbol]
      required :state, enum: -> { MeorphisTest40::Models::Card::State }

      # @!attribute [rw] type
      #   Card types:
      # * `VIRTUAL` - Card will authorize at any merchant and can be added to a digital wallet like Apple Pay or Google Pay (if the card program is digital wallet-enabled).
      # * `PHYSICAL` - Manufactured and sent to the cardholder. We offer white label branding, credit, ATM, PIN debit, chip/EMV, NFC and magstripe functionality. Reach out at [acme.com/contact](https://acme.com/contact) for more information.
      # * `SINGLE_USE` - Card is closed upon first successful authorization.
      # * `MERCHANT_LOCKED` - *[Deprecated]* Card is locked to the first merchant that successfully authorizes the card.
      #
      #   One of the constants defined in {MeorphisTest40::Models::Card::Type}
      #   @return [Symbol]
      required :type, enum: -> { MeorphisTest40::Models::Card::Type }

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
        #   @return [DateTime]
        required :created, DateTime

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
        #   One of the constants defined in {MeorphisTest40::Models::Card::Funding::State}
        #   @return [Symbol]
        required :state, enum: -> { MeorphisTest40::Models::Card::Funding::State }

        # @!attribute [rw] type
        #   Types of funding source:
        # * `DEPOSITORY_CHECKING` - Bank checking account.
        # * `DEPOSITORY_SAVINGS` - Bank savings account.
        #
        #   One of the constants defined in {MeorphisTest40::Models::Card::Funding::Type}
        #   @return [Symbol]
        required :type, enum: -> { MeorphisTest40::Models::Card::Funding::Type }

        # @!attribute [rw] account_name
        #   Account name identifying the funding source. This may be `null`.
        #   @return [String]
        optional :account_name, String

        # @!attribute [rw] nickname
        #   The nickname given to the `FundingAccount` or `null` if it has no nickname.
        #   @return [String]
        optional :nickname, String

        # State of funding source.
        #
        # Funding source states:
        # * `ENABLED` - The funding account is available to use for card creation and transactions.
        # * `PENDING` - The funding account is still being verified e.g. bank micro-deposits verification.
        # * `DELETED` - The founding account has been deleted.
        #
        class State < MeorphisTest40::Enum
          ENABLED = :ENABLED
          PENDING = :PENDING
          DELETED = :DELETED
        end

        # Types of funding source:
        # * `DEPOSITORY_CHECKING` - Bank checking account.
        # * `DEPOSITORY_SAVINGS` - Bank savings account.
        #
        class Type < MeorphisTest40::Enum
          DEPOSITORY_CHECKING = :DEPOSITORY_CHECKING
          DEPOSITORY_SAVINGS = :DEPOSITORY_SAVINGS
        end
      end

      # Spend limit duration values:
      # * `ANNUALLY` - Card will authorize transactions up to spend limit in a calendar year.
      # * `FOREVER` - Card will authorize only up to spend limit for the entire lifetime of the card.
      # * `MONTHLY` - Card will authorize transactions up to spend limit for the trailing month. Month is calculated as this calendar date one month prior.
      # * `TRANSACTION` - Card will authorize multiple transactions if each individual transaction is under the spend limit.
      #
      class SpendLimitDuration < MeorphisTest40::Enum
        ANNUALLY = :ANNUALLY
        FOREVER = :FOREVER
        MONTHLY = :MONTHLY
        TRANSACTION = :TRANSACTION
      end

      # Card state values:
      # * `CLOSED` - Card will no longer approve authorizations. Closing a card cannot be undone.
      # * `OPEN` - Card will approve authorizations (if they match card and account parameters).
      # * `PAUSED` - Card will decline authorizations, but can be resumed at a later time.
      # * `PENDING_FULFILLMENT` - The initial state for cards of type `PHYSICAL`. The card is provisioned pending manufacturing and fulfillment. Cards in this state can accept authorizations for e-commerce purchases, but not for "Card Present" purchases where the physical card itself is present.
      # * `PENDING_ACTIVATION` - Each business day at 2pm Eastern Time Zone (ET), cards of type `PHYSICAL` in state `PENDING_FULFILLMENT` are sent to the card production warehouse and updated to state `PENDING_ACTIVATION` . Similar to `PENDING_FULFILLMENT`, cards in this state can be used for e-commerce transactions. API clients should update the card's state to `OPEN` only after the cardholder confirms receipt of the card.
      #
      # In sandbox, the same daily batch fulfillment occurs, but no cards are actually manufactured.
      #
      class State < MeorphisTest40::Enum
        CLOSED = :CLOSED
        OPEN = :OPEN
        PAUSED = :PAUSED
        PENDING_ACTIVATION = :PENDING_ACTIVATION
        PENDING_FULFILLMENT = :PENDING_FULFILLMENT
      end

      # Card types:
      # * `VIRTUAL` - Card will authorize at any merchant and can be added to a digital wallet like Apple Pay or Google Pay (if the card program is digital wallet-enabled).
      # * `PHYSICAL` - Manufactured and sent to the cardholder. We offer white label branding, credit, ATM, PIN debit, chip/EMV, NFC and magstripe functionality. Reach out at [acme.com/contact](https://acme.com/contact) for more information.
      # * `SINGLE_USE` - Card is closed upon first successful authorization.
      # * `MERCHANT_LOCKED` - *[Deprecated]* Card is locked to the first merchant that successfully authorizes the card.
      #
      class Type < MeorphisTest40::Enum
        VIRTUAL = :VIRTUAL
        PHYSICAL = :PHYSICAL
        MERCHANT_LOCKED = :MERCHANT_LOCKED
        SINGLE_USE = :SINGLE_USE
      end
    end
  end
end
