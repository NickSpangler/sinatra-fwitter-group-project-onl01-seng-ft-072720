class UsersController < ApplicationController

    get "/signup" do
        if logged_in?
            redirect to "/tweets"
        else
            erb :"users/signup"
        end
    end
    
      get '/signup_error' do
        if logged_in?
            redirect to "/tweets"
        else
            erb :"/users/signup_error"
        end
      end
    
      post "/signup" do
        if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
          @user = User.new(params)
          @user.save
          session[:user_id] = @user.id
          redirect to "/tweets"
        else
          redirect to "/signup_error"
        end
      end

      get '/login' do
        if !logged_in?
          erb :"users/login"
        else
            redirect to '/tweets'
        end
      end

      post '/login' do
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect to '/tweets'
        else
            redirect to "/signup"
        end
      end

      get '/logout' do
        logout
        redirect to "/login"
      end

      get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'users/show'
      end
end
