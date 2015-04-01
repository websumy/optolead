module Bitrix
  class API
    include Bitrix::API::Requests

    attr_reader :access_token

    REST_URI = "#{ENV['BITRIX_24_URL']}/rest/"

    def initialize
      @access_token = Bitrix::Auth.get_local_access_token
    end
  end
end
