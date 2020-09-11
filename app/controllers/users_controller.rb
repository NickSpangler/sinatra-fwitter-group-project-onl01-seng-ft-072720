class UsersController < ApplicationController

    get "/signup" do
        erb :"users/signup"
      end
    
      get '/signup_error' do
        erb :"/users/signup_error"
      end
    
      post "/signup" do
        if !params[:username].empty?
          @user = User.create(params)
          redirect to "/tweets"
        else
          redirect to "/signup_error"
        end
      end

end
