class ContributionMailer < ApplicationMailer
  default from: 'noreply@laruche.fr'

  def new_contribution(contribution)
    @contribution = contribution
    mail(
      to: 'nicolas.goarant@gmail.com',
      subject: "🐝 Nouvelle contribution : #{@contribution.title}"
    )
  end
end
