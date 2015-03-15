class Listing < ActiveRecord::Base
  belongs_to :district
  belongs_to :dwelling_kind
	belongs_to :user
	has_many :listing_pictures

	def valid?
		if self.description.nil? || self.address.nil? then
			return false
		end
		return !self.description.empty? && !self.address.empty?
	end
end
