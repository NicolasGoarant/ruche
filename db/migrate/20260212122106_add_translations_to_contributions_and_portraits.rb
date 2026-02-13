class AddTranslationsToContributionsAndPortraits < ActiveRecord::Migration[7.2]
  def change
    unless column_exists?(:contributions, :translations)
      add_column :contributions, :translations, :jsonb, default: {}, null: false
    end
    unless column_exists?(:portraits, :translations)
      add_column :portraits, :translations, :jsonb, default: {}, null: false
    end
  end
end
