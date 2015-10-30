class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id]) # retrieve the user id > allow to request to the Users controller > params[:id] will be user id 1 < works the same as User.find(1)
  end
end
