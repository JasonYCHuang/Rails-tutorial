class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :is_correct_user!, except: [:index, :destroy]		# TBD (will be updated if using pundit)
	before_action :admin_user,     	 only: :destroy

	def index
		@users = User.all
  	end

	def show
		@user = User.find(params[:id])
	end

	def destroy
	    User.find(params[:id]).destroy
	    flash[:success] = "User deleted"
	    redirect_to users_url
	end

	private
		def is_correct_user!
	      @user = User.find(params[:id])
	      redirect_to root_path, alert: "You don't have the access right!" unless @user == current_user
	    end

	    def admin_user
      		redirect_to(root_url) unless current_user.admin?
    	end
end