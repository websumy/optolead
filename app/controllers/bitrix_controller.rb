class BitrixController < ApplicationController
  def index
    api ||= Bitrix::API.new
    result = api.make_list_request('crm.lead.list', {}, ['ID', 'TITLE', 'NAME', 'SECOND_NAME','LAST_NAME', 'COMMENTS', 'STATUS_ID'])
    render plain: result
  end

  def callback
    Bitrix::Auth.get_access_token(params[:code]) if params[:code]
    render nothing: true
  end

  def ping
    redirect_to Bitrix::Auth.get_request_token
  end
end
