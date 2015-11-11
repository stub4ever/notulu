class SessionsController < ApplicationController
  def new
  end

  def create #Create action for login
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password]) # Output only by valid user & right password return
        #Take into account of any object > if true > the user with given information will acess
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_to user  #Converts this to the route for the user's profile page:
    else
      flash.now[:danger] = 'Invalid email/password combination' #An error message
      render 'new' #retry login
    end
  end

  # Destroying a session (user logout)
  def destroy
    log_out if logged_in? #Logging out only if logged in
    redirect_to root_url
  end
end
