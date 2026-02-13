# app/models/concerns/translatable.rb
#
# Fournit des méthodes translated_* pour lire les champs depuis
# la colonne jsonb `translations` selon la locale courante.
#
# Usage dans le modèle :
#   include Translatable
#   translates :title, :description   # pour Contribution
#   translates :quote, :origin, :tags # pour Portrait
#
# Dans les vues :
#   c.translated_title  → traduction si dispo, sinon valeur FR
#   p.translated_quote  → idem

module Translatable
  extend ActiveSupport::Concern

  class_methods do
    def translates(*fields)
      fields.each do |field|
        define_method("translated_#{field}") do
          locale = I18n.locale.to_s
          return send(field) if locale == 'fr'

          trans = try(:translations)
          if trans.is_a?(Hash) && trans.dig(locale, field.to_s).present?
            trans[locale][field.to_s]
          else
            send(field)
          end
        end
      end
    end
  end
end
