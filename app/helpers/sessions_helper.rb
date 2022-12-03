module SessionsHelper
    #авторизаяция под данным пользователем
    def log_in(user)
        session[:user_id] = user.id
    end

        # запоминает позьзователя в саенсе
    def remember(user)
        user.remember
        cookies.permanent.encrypted[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
    end

    #возвращает авторизировавшегося пользователя
    def current_user
        if (user_id = session[:user_id])
            @current_user ||= User.find_by(id: user_id)
        elsif (user_id = cookies.encrypted[:user_id])
            user = User.find_by(id: user_id)
            if user && user.authenticated?(cookies[:remember_token])
                log_in user
                @current_user = user
            end
        end     
    end
    
    #Возвращает тру если пользователь есть
    def current_user?(user)
        user && user == current_user
    end

    #возвращает тру если пользователь зашёл
    def logged_in?
        !current_user.nil?
    end

    #выход текущим пользователем
    def log_out
        session.delete(:user_id)
        @current_user = nil
    end

    # забывает текущий сеанс
    def forget(user)
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end
    
    #выход текущим пользователем
    def log_out
        forget(current_user)
        session.delete(:user_id)
        @current_user = nil
    end

    # перенаправляет в сохранённую .
    def redirect_back_or(default)
        redirect_to(session[:forwarding_url] || default)
        session.delete(:forwarding_url)
    end

    # сохраняет урл
    def store_location
        session[:forwarding_url] = request.original_url if request.get?
    end
end
