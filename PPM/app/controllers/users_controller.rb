class UsersController < ApplicationController
  respond_to :html, :json
 
	def update
	  @user = User.find(params[:id])
	  @user.update_attributes(params[:user])
	  respond_with @user
	end

	def new
	  @user = User.new
	end

	def create
	  @user = User.new(params[:user])
	  if @user.save
	    redirect_to root_url, :notice => "Signed up!"
	  else
	    render "new"
	  end
	end

	def show
		if current_user
			@user = current_user
			render "profile"
	    else
			render "profile"
	    end
	end
end