class ContributionsController < ApplicationController
  # CSRF token is now included via the layout's meta tags
  # No need to skip verify_authenticity_token

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
      ContributionMailer.new_contribution(@contribution).deliver_now

      respond_to do |format|
        format.html {
          redirect_to root_path,
          notice: "🐝 Contribution bien reçue ! Nous l'analysons et la mettons en ligne d'ici demain. Merci à vous — L'équipe de la Ruche"
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
    contributions = Contribution.published.where.not(latitude: nil)

    render json: contributions.map { |c|
      {
        id: c.id,
        title: c.translated_title,
        description: c.translated_description,
        latitude: c.latitude,
        longitude: c.longitude,
        type: c.contribution_type,
        emoji: c.type_emoji,
        color: c.type_color,
        image_url: c.main_photo_url,
        author: "#{c.author_flag} #{c.author_name}",
        location: c.location
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
      :image_url, photos: [],
    )
  end
end
