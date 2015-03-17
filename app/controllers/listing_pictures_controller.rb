class ListingPicturesController < ApplicationController
	# POST     /listing_pictures(.:format)
	# Parameters: {"files"=>[#<ActionDispatch::Http::UploadedFile:0x000001041403c0 
	#		@tempfile=#<Tempfile:/var/folders/mg/rgy5lstj0cz_kqswb4rm6jsm0000gn/T/RackMultipart20150314-51840-27kxgt.JPG>, 
	#		@original_filename="KAR_8863.JPG", @content_type="image/jpeg", 
	#		@headers="Content-Disposition: form-data; name=\"files[]\"; filename=\"KAR_8863.JPG\"\r\nContent-Type: image/jpeg\r\n">]}
	def create
		#for live
		@listing_picture = ListingPicture.new(:avatar => params[:listing_pictures].last)
		@listing_picture.save!

		#for testing, give back the first listing
		#@listing_picture = ListingPicture.all.shuffle[0]

		respond_to do |format|
			format.html{ render :json => @listing_picture.to_jq_upload.to_json, :content_type => 'text/html', :layout => false }
		end
	
		
	end
	
	# GET      /listing_pictures/:listing_picture_id/thumb
	#display thumbnail
	def thumb
		@listing_picture = ListingPicture.find_by_id(params[:listing_picture_id])
		
		respond_to do |format|
			format.html{ render :template => 'listing_pictures/thumb.template', :locals => { :'@listing_picture' => @listing_picture } }
			format.template
			format.json{ render :json => @listing_picture.to_jq_upload }
		end
	end

	# DELETE   /listing_pictures/:id(.:format)
	def destroy
		@lp = ListingPicture.find_by_id(params[:id]) or not_found
		
		js false

		if @lp.destroy! then
			if session.has_key? :listing_pictures_id then
				Rails.logger.info 'session[:listing_pictures_id]= ' +  session[:listing_pictures_id].inspect
				session[:listing_pictures_id].delete(params[:id])
				Rails.logger.info 'after delete session[:listing_pictures_id]= ' +  session[:listing_pictures_id].inspect
			end
			respond_to do |format|
				format.js
			end	
		end
	end
end
