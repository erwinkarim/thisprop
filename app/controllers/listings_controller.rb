class ListingsController < ApplicationController
	#think about require user sign in for new and create pages

	# GET      /listings
	# GET      /users/:user_id/listings
	def index
	end

	# GET      /users/:user_id/listings(.:format)
	def user_listings
		@user = User.find_by_id(params[:user_id])
		@listings = @user.listings

		respond_to do |format|
			format.html
		end
	end

	def new
	end

	def create
	end

  def search
  end
end
