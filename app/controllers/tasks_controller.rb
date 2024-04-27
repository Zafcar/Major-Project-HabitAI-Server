class TasksController < ApplicationController
  include JSONAPI::ActsAsResourceController

  before_action :authenticate_devise_api_token!
  before_action :verify_ownership, only: %i[update destroy]

  def context
    { current_user: current_devise_api_user }
  end

  def index
    tasks = Task.where(user_id: current_devise_api_user.id)
    render json: tasks
  end

  private

  def verify_ownership
    task = Task.find_by_id(params[:id])
    return true if task.nil?

    return render json: { error: 'no access' }, status: :unauthorized if task.user_id != current_devise_api_user.id # rubocop:disable Style/RedundantReturn
  end
end
