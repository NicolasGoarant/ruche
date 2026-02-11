class Admin::ContributionsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_contribution, only: [:edit, :update, :destroy, :publish, :unpublish]
  layout 'admin'

  def index
    @contributions = Contribution.order(created_at: :desc)
    @contributions = @contributions.where(published: params[:published]) if params[:published].present?
  end

  def new
    @contribution = Contribution.new
  end

  def create
    @contribution = Contribution.new(contribution_params)
    @contribution.published = true  # Les contributions admin sont publiées directement

    if @contribution.save
      redirect_to admin_contributions_path, notice: '✅ Contribution créée et publiée'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @contribution.update(contribution_params)
      redirect_to admin_contributions_path, notice: '✅ Contribution mise à jour'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @contribution.destroy
    redirect_to admin_contributions_path, notice: '🗑 Contribution supprimée'
  end

  def publish
    @contribution.update(published: true)
    redirect_to admin_contributions_path, notice: '✅ Contribution publiée'
  end

  def unpublish
    @contribution.update(published: false)
    redirect_to admin_contributions_path, notice: '❌ Contribution dépubliée'
  end

  private

  def set_contribution
    @contribution = Contribution.find(params[:id])
  end

  def contribution_params
    params.require(:contribution).permit(
      :contribution_type,
      :title,
      :description,
      :location,
      :contact_info,
      :author_name,
      :author_flag,
      :image_url,
      photos: []
    )
  end
end
