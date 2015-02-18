class CreateListingPictures < ActiveRecord::Migration
  def change
    create_table :listing_pictures do |t|
      t.string :title
      t.string :caption

      t.timestamps null: false
    end
  end
end
