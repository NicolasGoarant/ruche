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

  def mentions_legales
  end

  def politique_confidentialite
  end

end
