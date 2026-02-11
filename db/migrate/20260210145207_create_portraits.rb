class CreatePortraits < ActiveRecord::Migration[7.1]
  def change
    create_table :portraits do |t|
      t.string :name, null: false
      t.string :origin, null: false
      t.string :flag, null: false
      t.text :quote, null: false
      t.string :tags, array: true, default: []
      t.string :avatar_color, default: '#F5A800'
      t.string :stripe_gradient
      t.integer :position, default: 0

      t.timestamps
    end

    add_index :portraits, :position
  end
end
