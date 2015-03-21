class AddDistrictAndDwellingKindToListings < ActiveRecord::Migration
  def change
    add_reference :listings, :district, index: true
    add_foreign_key :listings, :districts
    add_reference :listings, :dwelling_kind, index: true
    add_foreign_key :listings, :dwelling_kinds
  end
end
