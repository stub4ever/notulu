class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def index
    @users = User.paginate(:page => params[:page], :per_page => 15)
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id]) # retrieve the user id > allow to request to the Users controller > params[:id] will be user id 1 < works the same as User.find(1)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user # Allow to log in the user upon sign-up
      flash[:success] = "Welcome to the sample App!"    #  Adding a flash message to user sign-up
      redirect_to @user                                 # Allow auto redirect to user_url (@user) > action with a save a redirect
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  # initial user update action.
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated" #handle a succesful update
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # Confirms the correct user
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  #confirms a logged-in user
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

end
