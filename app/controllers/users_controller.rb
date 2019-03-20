  class UsersController < ApplicationController 
	before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user, only: [:destroy]

  def index
    #@users = User.paginate(page: params[:page])
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  def show
  	# @user = User.find_by id: params[:id]
  		@user = User.find(params[:id])
     # redirect_to root_url and return unless @users.activated? # nani ? 
  end

  def new
  	@user = User.new
  end
   	
  def create
    #@user = User.new(params[:user])    # Not the final implementation!
    @user = User.new(user_params)
    if @user.save
      # log_in @user #sau khi dang nhap xong se login 
      # flash[:success] = "Welcome to the Sample App!" # Handle a successful save.
      # redirect_to @user # hoac redirect_to user_url(@user) # build lai web/user #nhung se khong vao trang thai dang nhap
      @user.send_activation_email

      #UserMailer.account_activation(@user).deliver_now
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new' # neu login k thanh cong render 'new.html'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # Handle a successful update.
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end


  private

    def user_params # strong params de tranh tham so thua truyen vao
    	params.require(:user).permit(:name, :email, :password, :password_confirmation)
    		   #tra ve 1 phien ban hash voi cac thuoc tinh cho phep nhu name, email, pw, pw_confirm
    end

    #kiem tra xem user login chua?
    def logged_in_user
        unless logged_in?
          store_location
          flash[:danger] = "Please log in."
          redirect_to login_url
        end
    end

    #kiem tra co phai dung nguoi dung do khong, tranh truong hop user 1 edit user 2
    def correct_user
        @user = User.find(params[:id])
        redirect_to(root_path) unless current_user?(@user)
        #redirect_to(user_path) unless @user == current_user
    end

     # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin? #neu la user_clien thi direct ve trangchu
    end
end
