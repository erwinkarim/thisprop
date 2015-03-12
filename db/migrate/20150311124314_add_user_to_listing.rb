class AddUserToListing < ActiveRecord::Migration
  def change
    add_reference :listings, :user, index: true
    add_foreign_key :listings, :users
  end
end
