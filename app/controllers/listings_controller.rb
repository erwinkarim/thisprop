class ListingsController < ApplicationController
	#think about require user sign in for new and create pages

	# GET      /listings
	# GET      /users/:user_id/listings
	def index
		@listings = Listing.order(:created_at => :desc).limit(20)
	
		respond_to do |format|
			format.html
		end
	end

	# GET      /users/:user_id/listings(.:format)
	def user_listings
		@user = User.find_by_id(params[:user_id])
		@listings = @user.listings

		respond_to do |format|
			format.html
		end
	end

	# GET      /users/:user_id/listings/new
	def new

		#reuse session data if available
		if session.has_key? :listing then
			@listing = User.find_by_id(params[:user_id]).listings.new( session[:listing] )
		else
			@listing = User.find_by_id(params[:user_id]).listings.new
		end

		if session.has_key? :listing_pictures_id then
			@listing_pictures_id = session[:listing_pictures_id]
		end


	end

	# POST     /users/:user_id/listings(.:format)
	def create
		#@listing = User.find_by_id(params[:user_id]).listings.new( Rack::Utils.parse_nested_query(params[:listing]) )
		@listing = User.find_by_id(params[:user_id]).listings.new( session[:listing])
		if @listing.save! then
			session.delete :listing

			ListingPicture.where(:id => session[:listing_pictures_id]).each{|x| x.update_attribute(:listing_id, @listing.id) }
			session.delete :listing_pictures_id

			respond_to do |format|
				format.html { redirect_to @listing }
			end
		else
			render :status => :error
		end
	end

	# PATCH   /users/:user_id/listings/:id(.:format)
	# PUT			/users/:user_id/listings/:id(.:format)
	def update

		Rails.logger.info 'session[:listing]= ' +  session[:listing].inspect
		@listing = Listing.find_by_id(session[:listing]['id'])
		
		@listing.title = session[:listing]['title']
		@listing.address = session[:listing]['address']
		@listing.dwelling_kind_id = session[:listing]['dwelling_kind_id']
		@listing.district_id = session[:listing]['district_id']
		@listing.description = session[:listing]['description']

		if @listing.save! then
			#clear session
			session[:listing] = nil

			#session[:listing_pictures_id] = params[:listing_pictures]
			Rails.logger.info 'session[:listing_pictures_id]= ' +  session[:listing_pictures_id].inspect
			session[:listing_pictures_id].each{|x| ListingPicture.find_by_id(x).update_attribute(:listing_id, params[:id]) }
			session[:listing_pictures_id] = nil 
			respond_to do |format|
				format.html { redirect_to @listing }
			end
		else
			render :status => :internal_server_error
			redirect_to edit_user_listing_path(:user_id => params[:user_id], :id => params[:id], :listing => params[:listing])
		end
	end


  def search
  end
	
	# GET      /users/:user_id/listings/:id/edit(
	def edit
		#session.delete :listing_pictures_id

		@user = User.find_by_id(params[:user_id])
		@listing = @user.listings.find_by_id(params[:id])

		# reuse session data if avaiable
		if session.has_key? :listing then
			Rails.logger.info 'session[:listing]= ' +  session[:listing].inspect
		
			@listing.title = session[:listing]['title']
			@listing.address = session[:listing]['address']
			@listing.dwelling_kind_id = session[:listing]['dwelling_kind_id']
			@listing.district_id = session[:listing]['district_id']
			@listing.description = session[:listing]['description']
		end
	
		if session.has_key? :listing_pictures_id then
			@listing_pictures_id = session[:listing_pictures_id]
		else
			@listing_pictures_id = @listing.listing_pictures.pluck(:id)
		end

		respond_to do |format|
			format.html
		end
	end

	# GET      /listings/:id
	def show
		@listing = Listing.find_by_id(params[:id]) or not_found
		@listing_pictures = ListingPicture.where(:listing_id => @listing.id)
		@user = User.find_by_id(@listing.user_id)

		respond_to do |format|
			format.html
		end
	end

	# GET      /users/:user_id/listings/review
	# session data is generated in review process
	def review
		@action = params[:action_taken]
		@user = User.find_by_id params[:user_id]

			
		if @action == 'new' then	
			session[:listing] = params[:listing]
			@listing = User.find_by_id(params[:user_id]).listings.new( listing_params )
		else
			@listing = Listing.find_by_id(params[:listing]['id'])
			@listing.title = params[:listing]['title']
			@listing.district_id = params[:listing]['district_id']
			@listing.dwelling_kind_id = params[:listing]['dwelling_kind_id']
			@listing.description = params[:listing]['description']
			@listing.address = params[:listing]['address']
			session[:listing] = @listing
		end

		Rails.logger.info 'session[:listing]= ' +  session[:listing].inspect

		#save session info
		session[:listing_pictures_id] = params[:listing_pictures]
		Rails.logger.info 'session[:listing_pictures_id]= ' +  session[:listing_pictures_id].inspect
		@listing_pictures = ListingPicture.where :id => params[:listing_pictures]

		respond_to do |format|
			format.html
		end
	end

	# GET      /districts/:district_id/listing
	def district_listings
		@district = District.find_by_id(params[:district_id])
		@listings = @district.listings.order(:created_at => :desc).limit(10)
		
		respond_to do |format|
			format.html { render :template => 'listings/index', :locals => { :'@listings' => @listings } }
		end
	end

	# GET      /users/:user_id/listings/cancel(.:format)
	def cancel
		#clear session data when edit/new
		session.delete(:listing)
		session.delete(:listing_pictures_id)

		redirect_to user_listings_path(params[:user_id])
	end
	private
	def listing_params
		params.require(:listing).permit(:id, :title, :district_id, :dwelling_kind_id, :user_id, :description, :address )
	end
end
