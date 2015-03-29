class Listing < ActiveRecord::Base
  belongs_to :district
  belongs_to :dwelling_kind
	belongs_to :user
	has_many :listing_pictures
	validates  :description, :presence => true
	validates  :address, :presence => true
	validates :price, :presence => true

end
