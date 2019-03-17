module SessionsHelper
	def log_in(user)
    	session[:user_id] = user.id # su dung method session de tu dong ma hoa nguoi dung tranh attacker
  end

  def current_user # chua hieu cho nay
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      #raise       # The tests still pass, so this branch is currently untested.
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        remember user
        @current_user = user
      end
    end
  end

  def remember(user)
    user.remember #  goi tu model
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  
  def forget(user)
    user.forget # goi tu model
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
end
