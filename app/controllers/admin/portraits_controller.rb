class Admin::PortraitsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_portrait, only: [:edit, :update, :destroy]
  layout 'admin'

  def index
    @portraits = Portrait.order(created_at: :desc)
  end

  def new
    @portrait = Portrait.new
  end

  def create
    @portrait = Portrait.new(portrait_params)
    parse_tags

    if @portrait.save
      redirect_to admin_portraits_path, notice: '✅ Trajectoire créée'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @portrait.assign_attributes(portrait_params)
    parse_tags

    if @portrait.save
      redirect_to admin_portraits_path, notice: '✅ Trajectoire mise à jour'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @portrait.destroy
    redirect_to admin_portraits_path, notice: '🗑 Trajectoire supprimée'
  end

  private

  def set_portrait
    @portrait = Portrait.find(params[:id])
  end

  def portrait_params
    params.require(:portrait).permit(
      :name,
      :flag,
      :origin,
      :quote,
      :photo_url,
      :stripe_gradient
    )
  end

  def parse_tags
    if params[:portrait][:tags].is_a?(String)
      @portrait.tags = params[:portrait][:tags].split(',').map(&:strip).reject(&:blank?)
    end
  end
end
