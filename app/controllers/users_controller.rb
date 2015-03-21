class UsersController < ApplicationController
	def show
		@user = User.find_by_id(params[:id]) or not_found
	end

	def edit
		@user = User.find_by_id(params[:id]) or not_found
	end
end
