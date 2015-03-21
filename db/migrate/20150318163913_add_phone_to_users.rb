class AddPhoneToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phone_area_code, :string, :length => 3
    add_column :users, :phone, :integer
  end
end
