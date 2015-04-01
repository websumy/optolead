module Bitrix
  class Auth
    SERVER_ADDR       = ENV['SERVER_ADDR']
    RETURN_URI        = "http://#{SERVER_ADDR}/bitrix/oauth/callback"
    BITRIX_KEY        = ENV['BITRIX_KEY']
    BITRIX_SECRET     = ENV['BITRIX_SECRET']
    API_AUTHORIZE_URI = "#{ENV['BITRIX_24_URL']}/oauth/authorize/"
    API_TOKEN_URI     = "#{ENV['BITRIX_24_URL']}/oauth/token/"

    def self.get_request_token
      request = Typhoeus::Request.new(
          API_AUTHORIZE_URI,
          method: :get,
          params: default_params.merge!(response_type: 'code')
      )
      request.url
    end

    def self.get_access_token(request_token, refresh_token = nil)
      params = {
          client_secret: BITRIX_SECRET,
          scope: 'crm'
      }
      refresh_params = { grant_type: 'refresh_token', refresh_token: refresh_token }
      access_params = { grant_type: 'authorization_code', code: request_token }
      additional_hash = refresh_token ? refresh_params : access_params
      request = Typhoeus::Request.new(
          API_TOKEN_URI,
          method: :get,
          params: default_params.merge!(params).merge!(additional_hash)
      )
      request.run
      result = JSON.parse request.response.body
      record_access_data(result) if result['error'].nil? && result['access_token'].present?
      request.response.effective_url
    end

    def self.default_params
      {
          client_id: BITRIX_KEY,
          redirect_uri: RETURN_URI
      }
    end

    def self.record_access_data(hash)
      cache = Rails.cache
      cache.write('bitrix24:access_token', hash['access_token'])
      cache.write('bitrix24:refresh_token', hash['refresh_token'])
      cache.write('bitrix24:updated_at', Time.now)
    end

    def self.get_local_access_token
      cache = Rails.cache
      bua = cache.read('bitrix24:updated_at')
      time_diff = (Time.now.to_i - bua.to_time.to_i)
      if time_diff > 3600 || cache.read('bitrix24:access_token').blank?
        refresh_access_token
        get_local_access_token
      else
        cache.read('bitrix24:access_token')
      end
    end

    def self.refresh_access_token
      cache = Rails.cache
      brt = cache.read('bitrix24:refresh_token')
      Bitrix::Auth.get_access_token(nil, brt)
    end
  end
end
