class OmniauthCallbacksController < Devise::OmniauthCallbacksController
	def facebook
		@user = User.from_omniauth(request.env['omniauth.auth'])
		byebug
		if (@user.persisted?)
			sign_in_and_redirect @user, :event => :authentication
		else
			redirect_to root_path
		end
	end
end