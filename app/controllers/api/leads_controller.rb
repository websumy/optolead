class Api::LeadsController < ApiController
  def index
    @leads = current_user.leads.page(params[:page]).per(params[:per_page])
    render json: @leads, meta: { count: @leads.total_count }
  end

  def show
    @lead = current_user.leads.find(params[:id])
    render json: @lead
  end
end
