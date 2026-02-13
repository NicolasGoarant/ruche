class PortraitsController < ApplicationController
  def index
    @portraits = Portrait.ordered
  end

  def show
    @portrait = Portrait.find(params[:id])
  end
end
