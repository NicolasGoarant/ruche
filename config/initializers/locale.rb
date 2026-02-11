# config/initializers/locale.rb
# Configuration i18n pour la Ruche

I18n.available_locales = [:fr, :en, :ar, :uk, :prs, :es]
I18n.default_locale = :fr

# Fallback vers le français si une traduction manque
Rails.application.config.i18n.fallbacks = true
