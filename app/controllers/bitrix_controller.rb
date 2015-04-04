class BitrixController < ApplicationController
  def callback
    Bitrix::Auth.get_access_token(params[:code]) if params[:code]
    render nothing: true
  end

  def ping
    redirect_to Bitrix::Auth.get_request_token
  end
end
