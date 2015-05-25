class ApiCartli
  API_URL = 'https://erm.cartli.com.ua/services/api/'

  def initialize(token, key)
    @key = key
    @token = token
  end

  def send_request(action, params)
    request = prepare_request(action, params)

    uri = URI(API_URL + "?token=#{@token}")
    req = Net::HTTP::Post.new(uri)
    req.set_form_data(request)

    res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http.request(req)
    end

    JSON.parse res.body
  end

  def prepare_request(action, params)
    request_json = { action: action, params: params }.to_json
    data = Base64.encode64(request_json)
    sign = Base64.encode64(Digest::MD5.hexdigest(@key.to_s + request_json.to_s + @key.to_s))
    { data: data, sign: sign }
  end
end
