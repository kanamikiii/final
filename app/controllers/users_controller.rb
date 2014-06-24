class UsersController < ApplicationController
  	before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  	before_action :correct_user,   only: [:edit, :update]
  	before_action :admin_user,     only: :destroy

  	def index
  		@users = User.paginate(page: params[:page])
  	end

	def show
    	@user = User.find(params[:id])
    	@entries = @user.entries.paginate(page: params[:page])
 	end

 	# signup
  	def new
  		@user = User.new
  	end

  	def create
    	@user = User.new(user_params)    # Not the final implementation!
    	if @user.save
    		sign_in @user
      		flash[:success] = "Welcome to the Framgia Blog!"
      		redirect_to @user
    	else
      		render 'new'
    	end
  	end

  	def edit
    	# @user = User.find(params[:id])
  	end

  	def update
    	# @user = User.find(params[:id])
    	if @user.update_attributes(user_params)
      		# Handle a successful update.
      		flash[:success] = "Profile updated"
     		redirect_to @user
    	else
      		render 'edit'
    	end
  	end

  	def destroy
    	User.find(params[:id]).destroy
    	flash[:success] = "User deleted."
    	redirect_to users_url
  	end

  	private

  	def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # Before filters
    def signed_in_user
    	unless signed_in?
        	store_location
        	redirect_to signin_url, notice: "Please sign in."
      	end
    end

    def correct_user
      	@user = User.find(params[:id])
      	redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      	redirect_to(root_url) unless current_user.admin?
    end

end
