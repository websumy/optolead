class LeadsController < ApplicationController
  def index
    @leads = current_user.leads
  end

  def show
    @lead = current_user.leads.find(params[:id])
  end
end
