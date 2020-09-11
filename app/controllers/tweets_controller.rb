class TweetsController < ApplicationController

    get "/tweets" do
        if logged_in?
            @tweets = Tweet.all
            erb :"tweets/index"
        else
            redirect to '/login'
        end
    end

    post "/tweets" do
        if !params[:content].empty?
            @tweet = current_user.tweets.create(content: params[:content])
            redirect to "tweets/#{@tweet.id}"
        else
            redirect to "/tweets/new"
        end
    end

    get "/tweets/new" do
        if logged_in?
            erb :"tweets/new"
        else
            redirect to "/login"
        end
    end

    get "/tweets/:id" do
        if logged_in?
            @tweet = Tweet.find_by(id: params[:id])
            erb :"tweets/show"
        else
            redirect to "/login"
        end
    end

    get '/tweets/:id/edit' do
        if logged_in?
            @tweet = Tweet.find_by(id: params[:id])
            if @tweet.user.id == current_user.id
                erb :"/tweets/edit"
            else
                redirect to "/tweets"
            end
        else
            redirect to "/login"
        end
    end

    post "/tweets/:id" do
        if logged_in?
            @tweet = Tweet.find_by(id: params[:id])
            if !params[:content].empty? && current_user.id == @tweet.user.id
            @tweet.update(content: params[:content])
                redirect to "/tweets/#{@tweet.id}"
            else
                redirect to "/tweets/#{@tweet.id}/edit"
            end
        else
            redirect to "/login"
        end
    end

    delete "/tweets/:id" do
        @tweet = Tweet.find_by(id: params[:id])
        if @tweet.user.id == current_user.id
            @tweet.delete
            redirect to "/tweets"
        else
            redirect to "/tweets"
        end
    end

end
