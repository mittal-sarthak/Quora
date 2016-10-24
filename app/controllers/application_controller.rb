class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def custom_authenticate_user!
      #authenticate_user!
      authenticate_or_request_with_http_token do |access_token, options|
        if (!access_token.blank?)
          user = User.find_by_access_token(access_token)
          if (user.nil?)
            redirect_to root_path
          else 
            @user = user
          end
       end
      end
    end

    def current_signed_user
      current_user || @user
    end

  	def authenticate_author!
  		if (!user_signed_in?)
  			#redirect_to
  			return
  		end
  		if (current_user.role > User.roles[:author])
  			#redirect_to
  			return
  		end
  	end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end
end
