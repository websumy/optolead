class LeadsController < ApplicationController
  def index
    @q = current_user.leads.ransack(params[:q])
    @leads = @q.result.page(params[:page])
  end

  def show
    @lead = current_user.leads.find(params[:id])
  end
end
