# frozen_string_literal: true

module MeorphisTest40
  module Models
    class AccountConfiguration < BaseModel
      # @!attribute [rw] token
      #   Globally unique identifier for the account. This is the same as the account_token returned by the enroll endpoint. If using this parameter, do not include pagination.
      #
      #   @return [String]
      required :token, String

      # @!attribute [rw] spend_limit
      #   Spend limit information for the user containing the daily, monthly, and lifetime spend limit of the account. Any charges to a card owned by this account will be declined once their transaction volume has surpassed the value in the applicable time limit (rolling). A lifetime limit of 0 indicates that the lifetime limit feature is disabled.
      #
      #   @return [MeorphisTest40::Models::AccountConfiguration::SpendLimit]
      required :spend_limit, -> { MeorphisTest40::Models::AccountConfiguration::SpendLimit }

      # @!attribute [rw] state
      #   Account state:
      #   * `ACTIVE` - Account is able to transact and create new cards.
      #   * `PAUSED` - Account will not be able to transact or create new cards. It can be set back to `ACTIVE`.
      #   * `CLOSED` - Account will permanently not be able to transact or create new cards.
      #
      #   @return [Symbol, MeorphisTest40::Models::AccountConfiguration::State]
      required :state, enum: -> { MeorphisTest40::Models::AccountConfiguration::State }

      # @!attribute [rw] account_holder
      #   @return [MeorphisTest40::Models::AccountConfiguration::AccountHolder]
      optional :account_holder, -> { MeorphisTest40::Models::AccountConfiguration::AccountHolder }

      # @!attribute [rw] auth_rule_tokens
      #   List of identifiers for the Auth Rule(s) that are applied on the account.
      #
      #   @return [Array<String>]
      optional :auth_rule_tokens, MeorphisTest40::ArrayOf.new(String)

      # @!attribute [rw] verification_address
      #   @return [MeorphisTest40::Models::AccountConfiguration::VerificationAddress]
      optional :verification_address, -> { MeorphisTest40::Models::AccountConfiguration::VerificationAddress }

      class SpendLimit < BaseModel
        # @!attribute [rw] daily
        #   Daily spend limit (in cents).
        #   @return [Integer]
        required :daily, Integer

        # @!attribute [rw] lifetime
        #   Total spend limit over account lifetime (in cents).
        #   @return [Integer]
        required :lifetime, Integer

        # @!attribute [rw] monthly
        #   Monthly spend limit (in cents).
        #   @return [Integer]
        required :monthly, Integer

        # @!parse
        #   # Create a new instance of SpendLimit from a Hash of raw data.
        #   #
        #   # @param data [Hash{Symbol => Object}] .
        #   #   @option data [Integer] :daily Daily spend limit (in cents).
        #   #   @option data [Integer] :lifetime Total spend limit over account lifetime (in cents).
        #   #   @option data [Integer] :monthly Monthly spend limit (in cents).
        #   def initialize(data = {}) = super
      end

      # Account state:
      #   * `ACTIVE` - Account is able to transact and create new cards.
      #   * `PAUSED` - Account will not be able to transact or create new cards. It can be set back to `ACTIVE`.
      #   * `CLOSED` - Account will permanently not be able to transact or create new cards.
      #
      class State < MeorphisTest40::Enum
        ACTIVE = :ACTIVE
        PAUSED = :PAUSED
        CLOSED = :CLOSED
      end

      class AccountHolder < BaseModel
        # @!attribute [rw] token
        #   Globally unique identifier for the account holder.
        #   @return [String]
        required :token, String

        # @!attribute [rw] business_account_token
        #   Only applicable for customers using the KYC-Exempt workflow to enroll authorized users of businesses. Account_token of the enrolled business associated with an enrolled AUTHORIZED_USER individual.
        #   @return [String]
        required :business_account_token, String

        # @!attribute [rw] email
        #   Email address.
        #   @return [String]
        required :email, String

        # @!attribute [rw] phone_number
        #   Phone number of the individual.
        #   @return [String]
        required :phone_number, String

        # @!parse
        #   # Create a new instance of AccountHolder from a Hash of raw data.
        #   #
        #   # @param data [Hash{Symbol => Object}] .
        #   #   @option data [String] :token Globally unique identifier for the account holder.
        #   #   @option data [String] :business_account_token Only applicable for customers using the KYC-Exempt workflow to enroll authorized
        #   #     users of businesses. Account_token of the enrolled business associated with an
        #   #     enrolled AUTHORIZED_USER individual.
        #   #   @option data [String] :email Email address.
        #   #   @option data [String] :phone_number Phone number of the individual.
        #   def initialize(data = {}) = super
      end

      class VerificationAddress < BaseModel
        # @!attribute [rw] address1
        #   Valid deliverable address (no PO boxes).
        #   @return [String]
        required :address1, String

        # @!attribute [rw] city
        #   City name.
        #   @return [String]
        required :city, String

        # @!attribute [rw] country
        #   Country name. Only USA is currently supported.
        #   @return [String]
        required :country, String

        # @!attribute [rw] postal_code
        #   Valid postal code. Only USA ZIP codes are currently supported, entered as a five-digit ZIP or nine-digit ZIP+4.
        #   @return [String]
        required :postal_code, String

        # @!attribute [rw] state
        #   Valid state code. Only USA state codes are currently supported, entered in uppercase ISO 3166-2 two-character format.
        #   @return [String]
        required :state, String

        # @!attribute [rw] address2
        #   Unit or apartment number (if applicable).
        #   @return [String]
        optional :address2, String

        # @!parse
        #   # Create a new instance of VerificationAddress from a Hash of raw data.
        #   #
        #   # @param data [Hash{Symbol => Object}] .
        #   #   @option data [String] :address1 Valid deliverable address (no PO boxes).
        #   #   @option data [String] :city City name.
        #   #   @option data [String] :country Country name. Only USA is currently supported.
        #   #   @option data [String] :postal_code Valid postal code. Only USA ZIP codes are currently supported, entered as a
        #   #     five-digit ZIP or nine-digit ZIP+4.
        #   #   @option data [String] :state Valid state code. Only USA state codes are currently supported, entered in
        #   #     uppercase ISO 3166-2 two-character format.
        #   #   @option data [String, nil] :address2 Unit or apartment number (if applicable).
        #   def initialize(data = {}) = super
      end

      # @!parse
      #   # Create a new instance of AccountConfiguration from a Hash of raw data.
      #   #
      #   # @param data [Hash{Symbol => Object}] .
      #   #   @option data [String] :token Globally unique identifier for the account. This is the same as the
      #   #     account_token returned by the enroll endpoint. If using this parameter, do not
      #   #     include pagination.
      #   #   @option data [Object] :spend_limit Spend limit information for the user containing the daily, monthly, and lifetime
      #   #     spend limit of the account. Any charges to a card owned by this account will be
      #   #     declined once their transaction volume has surpassed the value in the applicable
      #   #     time limit (rolling). A lifetime limit of 0 indicates that the lifetime limit
      #   #     feature is disabled.
      #   #   @option data [String] :state
      #   #     Account state:
      #   #
      #   #     - `ACTIVE` - Account is able to transact and create new cards.
      #   #     - `PAUSED` - Account will not be able to transact or create new cards. It can be
      #   #       set back to `ACTIVE`.
      #   #     - `CLOSED` - Account will permanently not be able to transact or create new
      #   #       cards.
      #   #   @option data [Object, nil] :account_holder
      #   #   @option data [Array<String>, nil] :auth_rule_tokens List of identifiers for the Auth Rule(s) that are applied on the account.
      #   #   @option data [Object, nil] :verification_address
      #   def initialize(data = {}) = super
    end
  end
end
