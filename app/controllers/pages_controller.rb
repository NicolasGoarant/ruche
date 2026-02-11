class PagesController < ApplicationController
  layout false, only: [:home]

  def home
  end

  def droits
    @contents = StaticContent.by_category('droits')
                             .by_tags(params[:tags])
                             .ordered
  end

  def philosophie
  render layout: false
  end

end
