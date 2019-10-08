class TweetsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @tweets = Tweet.all.includes(:user)

    @tweets = @tweets.authored_by(params[:author]) if params[:author].present?

    @tweets_count = @tweets.count

    @tweets = @tweets.order(created_at: :desc).offset(params[:offset] || 0).limit(params[:limit] || 20)
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user

    if @tweet.save
      render :show
    else
      render json: { errors: @tweet.errors }, status: :unprocessable_entity
    end
  end

  def show
    @tweet = Tweet.find_by_slug!(params[:slug])
  end

  def update
    @tweet = Tweet.find_by_slug!(params[:slug])

    if @tweet.user_id == @current_user_id
      @tweet.update_attributes(tweet_params)

      render :show
    else
      render json: { errors: { tweet: ['not owned by user'] } }, status: :forbidden
    end
  end

  def destroy
    @tweet = Tweet.find_by_slug!(params[:slug])

    if @tweet.user_id == @current_user_id
      @tweet.destroy

      render json: {}
    else
      render json: { errors: { tweet: ['not owned by user'] } }, status: :forbidden
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:body)
  end
end