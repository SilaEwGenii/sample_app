class ApplicationController < ActionController::Base
    include SessionsHelper

    private

        # подтверждает авторизацйию пользователя.
        def logged_in_user
            unless logged_in?
                store_location
                flash[:danger] = "Please log in."
                redirect_to login_url
            end
        end

end
