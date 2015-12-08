class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to current_user
    else
      render 'users/create'
    end
  end

  def destroy
  end

  def write
    @micropost = current_user.microposts.build if logged_in?
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content)
  end

end
