class TweetsController < ApplicationController
  def index
    tweets = Tweet.order(created_at: :desc)

    if params[:cursor].present?
      tweets = tweets.where('id < ?', params[:cursor].to_i)
    end

    tweets = tweets.where(user_id: params[:user_id]) if params[:user_id].present?

    next_cursor = tweets.last&.id

    render json: {
      tweets: tweets.as_json,
      next_cursor: next_cursor
    }
  end
end
