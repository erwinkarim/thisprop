class AddListingToListingPictures < ActiveRecord::Migration
  def change
    add_reference :listing_pictures, :listing, index: true
    add_foreign_key :listing_pictures, :listings
  end
end
