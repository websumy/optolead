module Bitrix
  class API
    module Requests
      def make_create_request(method, fields = {})
        req = Typhoeus::Request.new(
            REST_URI + method,
            method: :get,
            params: fields.merge!(auth: @access_token)
        )
        req.run
        JSON.parse req.response.body
      end

      def make_update_request(method, id, fields = {})
        req = Typhoeus::Request.new(
            REST_URI + method,
            method: :post,
            params: { auth: @access_token, id: id }.merge!(fields: fields)
        )
        req.run
        JSON.parse req.response.body
      end

      def make_get_request(method, id)
        req = Typhoeus::Request.new(
            REST_URI + method,
            method: :get,
            params: { id: id }.merge!(auth: @access_token)
        )
        req.run
        JSON.parse req.response.body
      end

      def make_list_request(method, filter, select, offset = 0)
        req = Typhoeus::Request.new(
            REST_URI + method,
            method: :get,
            params: { filter: filter, select: select, start: offset }.merge!(auth: @access_token)
        )
        req.run
        JSON.parse req.response.body
      end
    end
  end
end
