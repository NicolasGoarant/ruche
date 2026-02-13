class ApplicationController < ActionController::Base
  before_action :set_locale

  private

  def set_locale
    locale = params[:locale]&.to_sym

    if locale && I18n.available_locales.include?(locale)
      I18n.locale = locale
    else
      I18n.locale = :fr
    end
  end

  def default_url_options
    if I18n.locale == :fr
      { locale: nil }
    else
      { locale: I18n.locale }
    end
  end
end
