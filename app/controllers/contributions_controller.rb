class ContributionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  layout false, only: [:show, :new]

  def index
    @contributions = Contribution.published
                                  .by_type(params[:type])
                                  .recent

    respond_to do |format|
      format.html
      format.json { render json: @contributions }
    end
  end

  def new
    @contribution = Contribution.new
  end

  def create
    @contribution = Contribution.new(contribution_params)

    if @contribution.save
      # Envoyer l'email à l'admin
      ContributionMailer.new_contribution(@contribution).deliver_now
      
      respond_to do |format|
        format.html { 
          redirect_to root_path, 
          notice: '🐝 Contribution bien reçue ! Nous l\'analysons et la mettons en ligne d\'ici demain. Merci à vous — L\'équipe de la Ruche' 
        }
        format.json { render json: @contribution, status: :created }
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @contribution.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @contribution = Contribution.find(params[:id])
  end

  def map_data
    contributions = Contribution.published
                                 .where.not(latitude: nil, longitude: nil)
                                 .by_type(params[:type])

    render json: contributions.map { |c|
      {
        id: c.id,
        type: c.contribution_type,
        title: c.title,
        description: c.description,
        location: c.location,
        latitude: c.latitude,
        longitude: c.longitude,
        emoji: c.type_emoji,
        color: c.type_color,
        author: c.author_name,
        flag: c.author_flag,
        image_url: c.main_photo_url,
        contributed: true
      }
    }
  end

  private

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
