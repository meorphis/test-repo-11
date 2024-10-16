# frozen_string_literal: true

require "time"

require_relative "test_helper"

class MeorphisTest40Test < Minitest::Test
  parallelize_me!

  def test_raises_on_both_base_url_and_environment
    e = assert_raises(ArgumentError) do
      MeorphisTest40::Client.new(
        base_url: "https://localhost:8000",
        environment: "production"
      )
    end
    assert_match(/both environment and base_url given/, e.message)
  end

  def test_raises_on_unknown_environment
    e = assert_raises(ArgumentError) do
      MeorphisTest40::Client.new(environment: "wrong")
    end
    assert_match(/environment must be one of/, e.message)
  end

  class MockResponse
    attr_accessor :code, :body, :content_type

    def initialize(code, data, headers)
      @headers = headers
      self.code = code
      self.body = JSON.generate(data)
      self.content_type = "application/json"
    end

    def [](header)
      @headers[header]
    end

    def key?(header)
      @headers.key?(header)
    end
  end

  class MockRequester
    attr_accessor :response_code, :response_data, :response_headers, :attempts

    def initialize(response_code, response_data, response_headers)
      self.response_code = response_code
      self.response_data = response_data
      self.response_headers = response_headers
      self.attempts = []
    end

    def execute(req, timeout:)
      # Deep copy the request because it is mutated on each retry.
      attempts.push(Marshal.load(Marshal.dump(req)))
      MockResponse.new(response_code, response_data, response_headers)
    end
  end

  def test_client_default_request_default_retry_attempts
    meorphis_test_46 = MeorphisTest40::Client.new(base_url: "http://localhost:4010")
    requester = MockRequester.new(500, {}, {"x-stainless-mock-sleep" => "true"})
    meorphis_test_46.requester = requester
    assert_raises(MeorphisTest40::HTTP::InternalServerError) do
      meorphis_test_46.cards.create({type: "VIRTUAL"})
    end
    assert_equal(3, requester.attempts.length)
  end

  def test_client_given_request_default_retry_attempts
    meorphis_test_46 = MeorphisTest40::Client.new(base_url: "http://localhost:4010", max_retries: 3)
    requester = MockRequester.new(500, {}, {"x-stainless-mock-sleep" => "true"})
    meorphis_test_46.requester = requester
    assert_raises(MeorphisTest40::HTTP::InternalServerError) do
      meorphis_test_46.cards.create({type: "VIRTUAL"})
    end
    assert_equal(4, requester.attempts.length)
  end

  def test_client_default_request_given_retry_attempts
    meorphis_test_46 = MeorphisTest40::Client.new(base_url: "http://localhost:4010")
    requester = MockRequester.new(500, {}, {"x-stainless-mock-sleep" => "true"})
    meorphis_test_46.requester = requester
    assert_raises(MeorphisTest40::HTTP::InternalServerError) do
      meorphis_test_46.cards.create({type: "VIRTUAL"}, max_retries: 3)
    end
    assert_equal(4, requester.attempts.length)
  end

  def test_client_given_request_given_retry_attempts
    meorphis_test_46 = MeorphisTest40::Client.new(base_url: "http://localhost:4010", max_retries: 3)
    requester = MockRequester.new(500, {}, {"x-stainless-mock-sleep" => "true"})
    meorphis_test_46.requester = requester
    assert_raises(MeorphisTest40::HTTP::InternalServerError) do
      meorphis_test_46.cards.create({type: "VIRTUAL"}, max_retries: 4)
    end
    assert_equal(5, requester.attempts.length)
  end

  def test_client_retry_after_seconds
    meorphis_test_46 = MeorphisTest40::Client.new(base_url: "http://localhost:4010", max_retries: 1)
    requester = MockRequester.new(500, {}, {"retry-after" => "1.3", "x-stainless-mock-sleep" => "true"})
    meorphis_test_46.requester = requester
    assert_raises(MeorphisTest40::HTTP::InternalServerError) do
      meorphis_test_46.cards.create({type: "VIRTUAL"})
    end
    assert_equal(2, requester.attempts.length)
    assert_equal(requester.attempts.last[:headers]["x-stainless-mock-slept"], 1.3)
  end

  def test_client_retry_after_date
    meorphis_test_46 = MeorphisTest40::Client.new(base_url: "http://localhost:4010", max_retries: 1)
    requester = MockRequester.new(
      500,
      {},
      {
        "retry-after" => (Time.now + 2).httpdate,
        "x-stainless-mock-sleep" => "true",
        "x-stainless-mock-sleep-base" => Time.now.httpdate
      }
    )
    meorphis_test_46.requester = requester
    assert_raises(MeorphisTest40::HTTP::InternalServerError) do
      meorphis_test_46.cards.create({type: "VIRTUAL"})
    end
    assert_equal(2, requester.attempts.length)
    assert_equal(requester.attempts.last[:headers]["x-stainless-mock-slept"], 2)
  end

  def test_client_retry_after_ms
    meorphis_test_46 = MeorphisTest40::Client.new(base_url: "http://localhost:4010", max_retries: 1)
    requester = MockRequester.new(500, {}, {"retry-after-ms" => "1300", "x-stainless-mock-sleep" => "true"})
    meorphis_test_46.requester = requester
    assert_raises(MeorphisTest40::HTTP::InternalServerError) do
      meorphis_test_46.cards.create({type: "VIRTUAL"})
    end
    assert_equal(2, requester.attempts.length)
    assert_equal(requester.attempts.last[:headers]["x-stainless-mock-slept"], 1.3)
  end

  def test_retry_count_header
    meorphis_test_46 = MeorphisTest40::Client.new(base_url: "http://localhost:4010")
    requester = MockRequester.new(500, {}, {"x-stainless-mock-sleep" => "true"})
    meorphis_test_46.requester = requester

    assert_raises(MeorphisTest40::HTTP::InternalServerError) do
      meorphis_test_46.cards.create({type: "VIRTUAL"})
    end

    retry_count_headers = requester.attempts.map { |a| a[:headers]["x-stainless-retry-count"] }
    assert_equal(%w[0 1 2], retry_count_headers)
  end

  def test_omit_retry_count_header
    meorphis_test_46 = MeorphisTest40::Client.new(base_url: "http://localhost:4010")
    requester = MockRequester.new(500, {}, {"x-stainless-mock-sleep" => "true"})
    meorphis_test_46.requester = requester

    assert_raises(MeorphisTest40::HTTP::InternalServerError) do
      meorphis_test_46.cards.create({type: "VIRTUAL"}, extra_headers: {"x-stainless-retry-count" => nil})
    end

    retry_count_headers = requester.attempts.map { |a| a[:headers]["x-stainless-retry-count"] }
    assert_equal([nil, nil, nil], retry_count_headers)
  end

  def test_overwrite_retry_count_header
    meorphis_test_46 = MeorphisTest40::Client.new(base_url: "http://localhost:4010")
    requester = MockRequester.new(500, {}, {"x-stainless-mock-sleep" => "true"})
    meorphis_test_46.requester = requester

    assert_raises(MeorphisTest40::HTTP::InternalServerError) do
      meorphis_test_46.cards.create({type: "VIRTUAL"}, extra_headers: {"x-stainless-retry-count" => "42"})
    end

    retry_count_headers = requester.attempts.map { |a| a[:headers]["x-stainless-retry-count"] }
    assert_equal(%w[42 42 42], retry_count_headers)
  end

  def test_client_redirect_307
    meorphis_test_46 = MeorphisTest40::Client.new(base_url: "http://localhost:4010")
    requester = MockRequester.new(307, {}, {"location" => "/redirected"})
    meorphis_test_46.requester = requester
    assert_raises(MeorphisTest40::HTTP::APIConnectionError) do
      meorphis_test_46.cards.create({type: "VIRTUAL"}, extra_headers: {})
    end
    assert_equal(requester.attempts[1][:path], "/redirected")
    assert_equal(requester.attempts[1][:method], requester.attempts[0][:method])
    assert_equal(requester.attempts[1][:body], requester.attempts[0][:body])
    assert_equal(
      requester.attempts[1][:headers]["content-type"],
      requester.attempts[0][:headers]["content-type"]
    )
  end

  def test_client_redirect_303
    meorphis_test_46 = MeorphisTest40::Client.new(base_url: "http://localhost:4010")
    requester = MockRequester.new(303, {}, {"location" => "/redirected"})
    meorphis_test_46.requester = requester
    assert_raises(MeorphisTest40::HTTP::APIConnectionError) do
      meorphis_test_46.cards.create({type: "VIRTUAL"}, extra_headers: {})
    end
    assert_equal(requester.attempts[1][:path], "/redirected")
    assert_equal(requester.attempts[1][:method], :get)
    assert_nil(requester.attempts[1][:body])
    assert_nil(requester.attempts[1][:headers]["Content-Type"])
  end

  def test_client_redirect_auth_keep_same_origin
    meorphis_test_46 = MeorphisTest40::Client.new(base_url: "http://localhost:4010")
    requester = MockRequester.new(307, {}, {"location" => "/redirected"})
    meorphis_test_46.requester = requester
    assert_raises(MeorphisTest40::HTTP::APIConnectionError) do
      meorphis_test_46.cards.create({type: "VIRTUAL"}, extra_headers: {"Authorization" => "Bearer xyz"})
    end
    assert_equal(
      requester.attempts[1][:headers]["authorization"],
      requester.attempts[0][:headers]["authorization"]
    )
  end

  def test_client_redirect_auth_strip_cross_origin
    meorphis_test_46 = MeorphisTest40::Client.new(base_url: "http://localhost:4010")
    requester = MockRequester.new(307, {}, {"location" => "https://example.com/redirected"})
    meorphis_test_46.requester = requester
    assert_raises(MeorphisTest40::HTTP::APIConnectionError) do
      meorphis_test_46.cards.create({type: "VIRTUAL"}, extra_headers: {"Authorization" => "Bearer xyz"})
    end
    assert_nil(requester.attempts[1][:headers]["Authorization"])
  end

  def test_default_headers
    meorphis_test_46 = MeorphisTest40::Client.new(base_url: "http://localhost:4010")
    requester = MockRequester.new(200, {}, {"x-stainless-mock-sleep" => "true"})
    meorphis_test_46.requester = requester
    meorphis_test_46.cards.create({type: "VIRTUAL"})
    headers = requester.attempts[0][:headers]
    refute_empty(headers["x-stainless-lang"])
    refute_empty(headers["x-stainless-package-version"])
    refute_empty(headers["x-stainless-runtime"])
    refute_empty(headers["x-stainless-runtime-version"])
  end
end
