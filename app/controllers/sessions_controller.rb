class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email(params[:email])

    if @user
      if @user.authenticate(params[:password])
        session[:user_id] = @user.id

        flash[:success] = 'Login successfully.'
        redirect_to root_path
      else
        flash.now[:error] = 'Incorrect password'
        render 'new'
      end
    else
      flash.now[:error] = 'User not found.'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    
    flash[:success] = 'Logout successfully.'
    redirect_to root_path
  end
end
