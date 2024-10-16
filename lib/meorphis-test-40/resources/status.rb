# frozen_string_literal: true

module MeorphisTest40
  module Resources
    class Status
      # @param client [MeorphisTest40::Client]
      def initialize(client:)
        @client = client
      end

      # API status check
      #
      # @param opts [Hash, MeorphisTest40::RequestOptions] Options to specify HTTP behaviour for this request.
      #
      # @return [MeorphisTest40::Models::StatusListResponse]
      def list(opts = {})
        req = {
          method: :get,
          path: "/status",
          model: MeorphisTest40::Models::StatusListResponse
        }
        @client.request(req, opts)
      end
    end
  end
end
