class StreaksController < ApplicationController
  include JSONAPI::ActsAsResourceController

  before_action :authenticate_devise_api_token!

  def context
    { current_user: current_devise_api_user }
  end

  def index
    streak = Streak.find_or_create_by(user_id: current_devise_api_user.id)
    streak.reset
    render json: streak
  end
end
