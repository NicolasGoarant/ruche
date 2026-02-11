class CreateContributions < ActiveRecord::Migration[7.1]
  def change
    create_table :contributions do |t|
      t.string :contribution_type, null: false
      t.string :title, null: false
      t.text :description, null: false
      t.string :location, null: false
      t.string :contact_info
      t.string :author_name, default: 'Anonyme'
      t.string :author_flag, default: '🌍'
      t.float :latitude
      t.float :longitude
      t.boolean :published, default: true

      t.timestamps
    end

    add_index :contributions, :contribution_type
    add_index :contributions, :published
    add_index :contributions, [:latitude, :longitude]
  end
end
