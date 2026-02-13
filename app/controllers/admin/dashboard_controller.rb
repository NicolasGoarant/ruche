class Admin::DashboardController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin'

  def index
    @pending_contributions = Contribution.where(published: false).order(created_at: :desc)
    @published_contributions = Contribution.where(published: true).order(created_at: :desc).limit(10)
    @total_contributions = Contribution.count
    @total_portraits = Portrait.count
  end
end
