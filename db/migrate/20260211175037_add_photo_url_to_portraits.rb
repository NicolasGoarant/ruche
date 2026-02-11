class AddPhotoUrlToPortraits < ActiveRecord::Migration[7.2]
  def change
    add_column :portraits, :photo_url, :string
  end
end
