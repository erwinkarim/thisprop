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
		if params.has_key? :listing then
			@listing = User.find_by_id(params[:user_id]).listings.new( Rack::Utils.parse_nested_query(params[:listing]) )
		else
			@listing = User.find_by_id(params[:user_id]).listings.new
		end
	end

	def create
		@listing = User.find_by_id(params[:user_id]).listings.new( Rack::Utils.parse_nested_query(params[:listing]) )
		if @listing.save! then
			respond_to do |format|
				format.html { redirect_to @listing }
			end
		else
			render :status => :error
		end
	end

  def search
  end
	
	# GET      /users/:user_id/listings/:id/edit(
	def edit
		@user = User.find_by_id(params[:user_id])
		@listing = @user.listings.find_by_id(params[:id])
		if params.has_key? :listing then
			listing_hash = Rack::Utils.parse_nested_query(params[:listing])
			@listing.title = listing_hash["title"]
			@listing.address = listing_hash["address"]
			@listing.dwelling_kind_id = listing_hash["dwelling_kind_id"]
			@listing.district_id = listing_hash["district_id"]
			@listing.description = listing_hash["description"]
		end
	
		respond_to do |format|
			format.html
		end
	end

	# GET      /listings/:id
	def show
		@listing = Listing.find_by_id(params[:id]) or not_found

		respond_to do |format|
			format.html
		end
	end

	# GET      /users/:user_id/listings/review
	def review
		@action = params[:action_taken]
	
		if @action == 'new' then	
			@listing = User.find_by_id(params[:user_id]).listings.new( listing_params )
		else
			@listing = Listing.find_by_id(params[:listing][:id])
			Rails.logger.info 'listing= ' + @listing.inspect
			@listing.title = params[:listing][:title]
			@listing.district_id = params[:listing][:district_id]
			@listing.dwelling_kind_id = params[:listing][:dwelling_kind_id]
			@listing.description = params[:listing][:description]
			@listing.address = params[:listing][:address]
		end

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

	# PATCH   /users/:user_id/listings/:id(.:format)
	# PUT			/users/:user_id/listings/:id(.:format)
	def update
	end

	private
	def listing_params
		params.require(:listing).permit(:id, :title, :district_id, :dwelling_kind_id, :user_id, :description, :address )
	end
end
