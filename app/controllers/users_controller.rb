class UsersController < ApplicationController 
	def show
  	# @user = User.find_by id: params[:id]
  		@user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end
   	
  def create
    #@user = User.new(params[:user])    # Not the final implementation!
    @user = User.new(user_params)
    if @user.save
      log_in @user #sau khi dang nhap xong se login 
      flash[:success] = "Welcome to the Sample App!" # Handle a successful save.
      redirect_to @user # hoac redirect_to user_url(@user) # build lai web/user #nhung se khong vao trang thai dang nhap
    else
    render 'new'
    end
  end

  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  		   #tra ve 1 phien ban hash voi cac thuoc tinh cho phep nhu name, email, pw, pw_confirm
  end
end
