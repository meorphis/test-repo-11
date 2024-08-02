# frozen_string_literal: true

module MeorphisTest40
  module Resources
    class Cards
      # @return [MeorphisTest40::Resources::Cards::FinancialTransactions]
      attr_reader :financial_transactions

      def initialize(client:)
        @client = client
        @financial_transactions = MeorphisTest40::Resources::Cards::FinancialTransactions.new(client: client)
      end

      # Create a new virtual or physical card. Parameters `pin`, `shipping_address`, and
      #   `product_id` only apply to physical cards.
      #
      # @param params [Hash] Attributes to send in this request.
      # @option params [Symbol] :type
      #   Body param: Card types:
      #
      #   - `VIRTUAL` - Card will authorize at any merchant and can be added to a digital
      #     wallet like Apple Pay or Google Pay (if the card program is digital
      #     wallet-enabled).
      #   - `PHYSICAL` - Manufactured and sent to the cardholder. We offer white label
      #     branding, credit, ATM, PIN debit, chip/EMV, NFC and magstripe functionality.
      #     Reach out at [acme.com/contact](https://acme.com/contact) for more
      #     information.
      #   - `SINGLE_USE` - Card is closed upon first successful authorization.
      #   - `MERCHANT_LOCKED` - _[Deprecated]_ Card is locked to the first merchant that
      #     successfully authorizes the card.
      # @option params [String] :account_token Body param: Globally unique identifier for the account that the card will be
      #   associated with. Required for programs enrolling users using the
      #   [/account_holders endpoint](https://docs.acme.com/docs/account-holders-kyc). See
      #   [Managing Your Program](doc:managing-your-program) for more information.
      # @option params [String] :card_program_token Body param: For card programs with more than one BIN range. This must be
      #   configured with Acme before use. Identifies the card program/BIN range under
      #   which to create the card. If omitted, will utilize the program's default
      #   `card_program_token`. In Sandbox, use 00000000-0000-0000-1000-000000000000 and
      #   00000000-0000-0000-2000-000000000000 to test creating cards on specific card
      #   programs.
      # @option params [Carrier] :carrier Body param:
      # @option params [String] :digital_card_art_token Body param: Specifies the digital card art to be displayed in the user’s digital
      #   wallet after tokenization. This artwork must be approved by Mastercard and
      #   configured by Acme to use. See
      #   [Flexible Card Art Guide](https://docs.acme.com/docs/about-digital-wallets#flexible-card-art).
      # @option params [String] :exp_month Body param: Two digit (MM) expiry month. If neither `exp_month` nor `exp_year`
      #   is provided, an expiration date will be generated.
      # @option params [String] :exp_year Body param: Four digit (yyyy) expiry year. If neither `exp_month` nor `exp_year`
      #   is provided, an expiration date will be generated.
      # @option params [String] :memo Body param: Friendly name to identify the card. We recommend against using this
      #   field to store JSON data as it can cause unexpected behavior.
      # @option params [String] :pin Body param: Encrypted PIN block (in base64). Only applies to cards of type
      #   `PHYSICAL` and `VIRTUAL`. See
      #   [Encrypted PIN Block](https://docs.acme.com/docs/cards#encrypted-pin-block-enterprise).
      # @option params [String] :product_id Body param: Only applicable to cards of type `PHYSICAL`. This must be configured
      #   with Acme before use. Specifies the configuration (i.e., physical card art) that
      #   the card should be manufactured with.
      # @option params [ShippingAddress] :shipping_address Body param:
      # @option params [Symbol] :shipping_method Body param: Shipping method for the card. Only applies to cards of type
      #   PHYSICAL. Use of options besides `STANDARD` require additional permissions.
      #
      #   - `STANDARD` - USPS regular mail or similar international option, with no
      #     tracking
      #   - `STANDARD_WITH_TRACKING` - USPS regular mail or similar international option,
      #     with tracking
      #   - `PRIORITY` - USPS Priority, 1-3 day shipping, with tracking
      #   - `EXPRESS` - FedEx Express, 3-day shipping, with tracking
      #   - `2_DAY` - FedEx 2-day shipping, with tracking
      #   - `EXPEDITED` - FedEx Standard Overnight or similar international option, with
      #     tracking
      # @option params [Integer] :spend_limit Body param: Amount (in cents) to limit approved authorizations. Transaction
      #   requests above the spend limit will be declined. Note that a spend limit of 0 is
      #   effectively no limit, and should only be used to reset or remove a prior limit.
      #   Only a limit of 1 or above will result in declined transactions due to checks
      #   against the card limit.
      # @option params [Symbol] :spend_limit_duration
      #   Body param: Spend limit duration values:
      #
      #   - `ANNUALLY` - Card will authorize transactions up to spend limit in a calendar
      #     year.
      #   - `FOREVER` - Card will authorize only up to spend limit for the entire lifetime
      #     of the card.
      #   - `MONTHLY` - Card will authorize transactions up to spend limit for the
      #     trailing month. Month is calculated as this calendar date one month prior.
      #   - `TRANSACTION` - Card will authorize multiple transactions if each individual
      #     transaction is under the spend limit.
      # @option params [Symbol] :state
      #   Body param: Card state values:
      #
      #   - `OPEN` - Card will approve authorizations (if they match card and account
      #     parameters).
      #   - `PAUSED` - Card will decline authorizations, but can be resumed at a later
      #     time.
      # @option params [String] :idempotency_key Header param: Idempotency key for the POST request. See
      #   [Idempotency Requests](https://docs.acme.com/docs/idempotent-requests) for
      #   details on behavior such as cache duration.
      #
      # @param opts [Hash|RequestOptions] Options to specify HTTP behaviour for this request.
      #
      # @return [MeorphisTest40::Models::Card]
      def create(params = {}, opts = {})
        req = {}
        req[:method] = :post
        req[:path] = "/cards"
        req[:body] = params
        req[:model] = MeorphisTest40::Models::Card
        @client.request(req, opts)
      end

      # Get card configuration such as spend limit and state.
      #
      # @param card_token [String]
      # @param opts [Hash|RequestOptions] Options to specify HTTP behaviour for this request.
      #
      # @return [MeorphisTest40::Models::Card]
      def retrieve(card_token, opts = {})
        req = {}
        req[:method] = :get
        req[:path] = "/cards/#{card_token}"
        req[:model] = MeorphisTest40::Models::Card
        @client.request(req, opts)
      end

      # Update the specified properties of the card. Unsupplied properties will remain
      #   unchanged. `pin` parameter only applies to physical cards.
      #
      #   _Note: setting a card to a `CLOSED` state is a final action that cannot be
      #   undone._
      #
      # @param card_token [String]
      #
      # @param params [Hash] Attributes to send in this request.
      # @option params [String] :auth_rule_token Identifier for any Auth Rules that will be applied to transactions taking place
      #   with the card.
      # @option params [String] :digital_card_art_token Specifies the digital card art to be displayed in the user’s digital wallet
      #   after tokenization. This artwork must be approved by Mastercard and configured
      #   by Acme to use. See
      #   [Flexible Card Art Guide](https://docs.acme.com/docs/about-digital-wallets#flexible-card-art).
      # @option params [String] :memo Friendly name to identify the card. We recommend against using this field to
      #   store JSON data as it can cause unexpected behavior.
      # @option params [String] :pin Encrypted PIN block (in base64). Only applies to cards of type `PHYSICAL` and
      #   `VIRTUAL`. See
      #   [Encrypted PIN Block](https://docs.acme.com/docs/cards#encrypted-pin-block-enterprise).
      # @option params [Integer] :spend_limit Amount (in cents) to limit approved authorizations. Transaction requests above
      #   the spend limit will be declined. Note that a spend limit of 0 is effectively no
      #   limit, and should only be used to reset or remove a prior limit. Only a limit of
      #   1 or above will result in declined transactions due to checks against the card
      #   limit.
      # @option params [Symbol] :spend_limit_duration
      #   Spend limit duration values:
      #
      #   - `ANNUALLY` - Card will authorize transactions up to spend limit in a calendar
      #     year.
      #   - `FOREVER` - Card will authorize only up to spend limit for the entire lifetime
      #     of the card.
      #   - `MONTHLY` - Card will authorize transactions up to spend limit for the
      #     trailing month. Month is calculated as this calendar date one month prior.
      #   - `TRANSACTION` - Card will authorize multiple transactions if each individual
      #     transaction is under the spend limit.
      # @option params [Symbol] :state
      #   Card state values:
      #
      #   - `CLOSED` - Card will no longer approve authorizations. Closing a card cannot
      #     be undone.
      #   - `OPEN` - Card will approve authorizations (if they match card and account
      #     parameters).
      #   - `PAUSED` - Card will decline authorizations, but can be resumed at a later
      #     time.
      #
      # @param opts [Hash|RequestOptions] Options to specify HTTP behaviour for this request.
      #
      # @return [MeorphisTest40::Models::Card]
      def update(card_token, params = {}, opts = {})
        req = {}
        req[:method] = :patch
        req[:path] = "/cards/#{card_token}"
        req[:body] = params
        req[:model] = MeorphisTest40::Models::Card
        @client.request(req, opts)
      end

      # Allow your cardholders to directly add payment cards to the device's digital
      #   wallet (e.g. Apple Pay) with one touch from your app.
      #
      #   This requires some additional setup and configuration. Please
      #   [Contact Us](https://acme.com/contact) or your Customer Success representative
      #   for more information.
      #
      # @param card_token [String] Path param: The unique token of the card to add to the device's digital wallet.
      #
      # @param params [Hash] Attributes to send in this request.
      # @option params [String] :certificate Body param: Only applicable if `digital_wallet` is `APPLE_PAY`. Omit to receive
      #   only `activationData` in the response. Apple's public leaf certificate. Base64
      #   encoded in PEM format with headers `(-----BEGIN CERTIFICATE-----)` and trailers
      #   omitted. Provided by the device's wallet.
      # @option params [Symbol] :digital_wallet Body param: Name of digital wallet provider.
      # @option params [String] :nonce Body param: Only applicable if `digital_wallet` is `APPLE_PAY`. Omit to receive
      #   only `activationData` in the response. Base64 cryptographic nonce provided by
      #   the device's wallet.
      # @option params [String] :nonce_signature Body param: Only applicable if `digital_wallet` is `APPLE_PAY`. Omit to receive
      #   only `activationData` in the response. Base64 cryptographic nonce provided by
      #   the device's wallet.
      # @option params [String] :idempotency_key Header param: Idempotency key for the POST request. See
      #   [Idempotency Requests](https://docs.acme.com/docs/idempotent-requests) for
      #   details on behavior such as cache duration.
      #
      # @param opts [Hash|RequestOptions] Options to specify HTTP behaviour for this request.
      #
      # @return [MeorphisTest40::Models::CardProvisionResponse]
      def provision(card_token, params = {}, opts = {})
        req = {}
        req[:method] = :post
        req[:path] = "/cards/#{card_token}/provision"
        req[:body] = params
        req[:model] = MeorphisTest40::Models::CardProvisionResponse
        @client.request(req, opts)
      end
    end
  end
end
