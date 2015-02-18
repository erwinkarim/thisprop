class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :title
      t.references :district, index: true
      t.references :dwelling_kind, index: true

      t.timestamps null: false
    end
    add_foreign_key :listings, :districts
    add_foreign_key :listings, :dwelling_kinds
  end
end
