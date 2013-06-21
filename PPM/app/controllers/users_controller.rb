class UsersController < ApplicationController
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
			puts "Yes"
			render "profile"
	    else
	    	puts "No"
	        redirect_to root_url, :notice => "Please sign in to access your profile!"
	    end
	end
end