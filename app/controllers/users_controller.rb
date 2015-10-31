class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id]) # retrieve the user id > allow to request to the Users controller > params[:id] will be user id 1 < works the same as User.find(1)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the sample App!"    #  Adding a flash message to user sign-up
      redirect_to @user                                 # Allow auto redirect to user_url (@user) > action with a save a redirect
    else
      render 'new'
    end
  end

  private

  def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
