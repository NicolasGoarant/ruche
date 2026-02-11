class CreateStaticContents < ActiveRecord::Migration[7.1]
  def change
    create_table :static_contents do |t|
      t.string :category, null: false
      t.string :slug, null: false
      t.string :title, null: false
      t.text :description, null: false
      t.string :icon
      t.string :tags, array: true, default: []
      t.integer :position, default: 0

      t.timestamps
    end

    add_index :static_contents, [:category, :slug], unique: true
    add_index :static_contents, :category
  end
end
