class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase) 
  	#bam user ra de lay email tim kiem trong csdl, neu user != null thi xac nhan pw
  	# user && => xac nhan user hop le
    if user && user.authenticate(params[:session][:password]) # ham nay trong has_secure_pw, dung de ma hoa pw da nhap vao
      if user.activated?
        log_in user # ham log_in duoc goi trong helpers/session_helper
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        message = "Account not activated"
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
        #redirect_to user
      end
    else
      # Create an error message.
      flash.now[:danger] = 'Invalid email/password combination' # Not quite right!
      # da~ thay the flash = flash.now khi gui 1 request khac thi no se tat cai flash di
      
      render 'new' #render ve page login 
    end
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
