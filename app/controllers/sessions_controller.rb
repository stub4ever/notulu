class SessionsController < ApplicationController
  def new
  end

  def create #Create action for login
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password]) # Output only by valid user & right password return
        log_in user #Log the user in and redirect to the user's show page
        redirect_to user  #Converts this to the route for the user's profile page:
    else
      flash.now[:danger] = 'Invalid email/password combination' #An error message
      render 'new' #retry login
    end
  end
end
