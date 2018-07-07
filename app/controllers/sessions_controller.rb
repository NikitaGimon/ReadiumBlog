class SessionsController < ApplicationController
    def new

    end

    def create
        user = User.find_by(email: params[:session][:email])
        if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.id
            flash[:success] = "Logged in"
            redirect_to user_path(user)
        else
            #for one http request
            flash.now[:danger] = "There was smth wrong with your login information"
            render 'new'
        end
    end

    def destroy
        session[:user_id] = nil
        flash[:success] = "You have logged out"
        redirect_to root_path
    end
  end