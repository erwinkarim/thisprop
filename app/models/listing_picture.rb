require 'carrierwave/orm/activerecord'

class ListingPicture < ActiveRecord::Base
	belongs_to :listing
  mount_uploader :avatar, AvatarUploader
  include Rails.application.routes.url_helpers
	

	def to_jq_upload
		{ :files => 
      [{
        #"name" => self.avatar.to_s.split('/').last, 
				"id" => self.id,
        "name" => self.avatar.to_s.split('/').last,
        "size" => self.avatar.size,
        "url" => self.avatar.url, 
        "thumbnail_url" => self.avatar.thumb150.url,
				"thumbnail_template" => listing_picture_thumb_path(self),
        "delete_url" => listing_picture_path(self),
        "delete_type" => "DELETE"
      }]
    }
	end
end
