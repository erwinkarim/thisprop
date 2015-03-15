class AddAvatarToListingPictures < ActiveRecord::Migration
  def change
    add_column :listing_pictures, :avatar, :string
  end
end
