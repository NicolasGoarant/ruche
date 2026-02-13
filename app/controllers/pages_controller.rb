class PagesController < ApplicationController
  def home
    @contributions = Contribution.published.recent.limit(6)
    @portraits = Portrait.ordered.limit(3)
  end

  def droits
    @contents = StaticContent.by_category('droits')
                             .by_tags(params[:tags])
                             .ordered
  end

  def philosophie
  end
end
