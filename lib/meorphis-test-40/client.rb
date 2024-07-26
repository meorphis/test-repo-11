# frozen_string_literal: true

module MeorphisTest40
  class Client < BaseClient
    # Default max number of retries to attempt after a failed retryable request.
    DEFAULT_MAX_RETRIES = 2

    # Client options.
    attr_reader

    # @return [MeorphisTest40::Resources::Accounts]
    attr_reader :accounts

    # @return [MeorphisTest40::Resources::Cards]
    attr_reader :cards

    # @return [MeorphisTest40::Resources::Status]
    attr_reader :status

    # Creates and returns a new client for interacting with the API.
    def initialize(environment: nil, base_url: nil, max_retries: nil)
      environments = {"production" => "https://api.acme.com/v1", "environment_1" => "https://sandbox.acme.com/v1"}
      if environment && base_url
        raise ArgumentError, "both environment and base_url given, expected only one"
      elsif environment
        if !environments.key?(environment.to_s)
          raise ArgumentError, "environment must be one of #{environments.keys}, got #{environment}"
        end
        base_url = environments[environment.to_s]
      elsif !base_url
        base_url = "https://api.acme.com/v1"
      end

      max_retries ||= DEFAULT_MAX_RETRIES

      super(base_url: base_url, max_retries: max_retries)

      @accounts = MeorphisTest40::Resources::Accounts.new(client: self)
      @cards = MeorphisTest40::Resources::Cards.new(client: self)
      @status = MeorphisTest40::Resources::Status.new(client: self)
    end

    # @!visibility private
    def make_status_error(message:, body:, response:)
      case response.code.to_i
      when 400
        MeorphisTest40::HTTP::BadRequestError.new(message: message, response: response, body: body)
      when 401
        MeorphisTest40::HTTP::AuthenticationError.new(message: message, response: response, body: body)
      when 403
        MeorphisTest40::HTTP::PermissionDeniedError.new(message: message, response: response, body: body)
      when 404
        MeorphisTest40::HTTP::NotFoundError.new(message: message, response: response, body: body)
      when 409
        MeorphisTest40::HTTP::ConflictError.new(message: message, response: response, body: body)
      when 422
        MeorphisTest40::HTTP::UnprocessableEntityError.new(message: message, response: response, body: body)
      when 429
        MeorphisTest40::HTTP::RateLimitError.new(message: message, response: response, body: body)
      when 500..599
        MeorphisTest40::HTTP::InternalServerError.new(message: message, response: response, body: body)
      else
        MeorphisTest40::HTTP::APIStatusError.new(message: message, response: response, body: body)
      end
    end
  end
end
