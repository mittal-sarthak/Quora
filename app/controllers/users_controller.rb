class UsersController < ApplicationController

	def signin
		@user = User.find_by_email(params[:email])
		if (@user.nil? || !@user.valid_password?(params[:password]))
			render json: "Invalid Username or Password", status: :unprocessable_entity
		else 
			@user.generate_access_token
			render json: @user
		end
	end
end