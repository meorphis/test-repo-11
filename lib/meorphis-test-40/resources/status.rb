# frozen_string_literal: true

module MeorphisTest40
  module Resources
    class Status
      def initialize(client:)
        @client = client
      end

      # API status check
      # 
      # @param opts [Hash|RequestOptions] Options to specify HTTP behaviour for this request.
      # 
      # @return [MeorphisTest40::Models::StatusListResponse]
      def list(opts = {})
        req = {}
        req[:method] = :get
        req[:path] = "/status"
        req[:model] = MeorphisTest40::Models::StatusListResponse
        @client.request(req, opts)
      end
    end
  end
end
