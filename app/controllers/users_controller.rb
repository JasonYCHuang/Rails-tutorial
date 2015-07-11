class UsersController < ApplicationController
	before_action :authenticate_user!	#, except: [:show]
	#before_action :is_correct_user!, except: [:index, :show, :destroy, :following, :followers]		# TBD (will be updated if using pundit)
	before_action :admin_user,     	 only: :destroy

	def index
		@users = User.all
  	end

	def show
		@user = User.find(params[:id])
		@microposts = @user.microposts.paginate(page: params[:page])
	end

	def destroy
	    User.find(params[:id]).destroy
	    flash[:success] = "User deleted"
	    redirect_to users_url
	end

	def following
		@title = "Following"
		@user  = User.find(params[:id])
		@users = @user.following.paginate(page: params[:page])
		render 'show_follow'
	end

	def followers
		@title = "Followers"
		@user  = User.find(params[:id])
		@users = @user.followers.paginate(page: params[:page])
		render 'show_follow'
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