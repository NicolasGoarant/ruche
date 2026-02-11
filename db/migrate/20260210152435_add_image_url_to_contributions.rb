class AddImageUrlToContributions < ActiveRecord::Migration[7.2]
  def change
    add_column :contributions, :image_url, :string
  end
end
