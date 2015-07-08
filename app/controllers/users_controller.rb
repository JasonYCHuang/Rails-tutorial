class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :is_correct_user!, except: [:index]		# TBD (will be updated if using pundit)

	def index
		@users = User.all
  	end

	def show
		@user = User.find(params[:id])
	end

	private
		def is_correct_user!
	      @user = User.find(params[:id])
	      redirect_to root_path, alert: "You don't have the access right!" unless @user == current_user
	    end

end