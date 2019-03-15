class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase) 
  	#bam user ra de lay email tim kiem trong csdl, neu user != null thi xac nhan pw
  	# user && => xac nhan user hop le
    if user && user.authenticate(params[:session][:password]) # ham nay trong has_secure_pw, dung de ma hoa pw da nhap vao
      log_in user # ham log_in duoc goi trong helpers/session_helper
      redirect_to user
    else
      # Create an error message.
      flash.now[:danger] = 'Invalid email/password combination' # Not quite right!
      # da~ thay the flash = flash.now khi gui 1 request khac thi no se tat cai flash di
      
      render 'new' #render ve page login 
    end
  end
  
  def destroy
    log_out
    redirect_to root_url
  end
end
