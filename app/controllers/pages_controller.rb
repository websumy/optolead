class PagesController < ApplicationController
  skip_before_filter :authenticate_user!

  def show
    @page = Page.friendly.find(params[:page_id])
  end
end