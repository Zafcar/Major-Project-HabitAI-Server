class SubTasksController < ApplicationController
  include JSONAPI::ActsAsResourceController

  before_action :authenticate_devise_api_token!
  before_action :verify_ownership, only: %i[update destroy mark_complete mark_complete]
  before_action :verify_task_ownership, only: %i[create]

  def context
    { current_user: current_devise_api_user }
  end

  def index
    task_id = params.dig(:data, :attributes, :task_id)
    return render json: { error: 'task_id is not provided ' } if task_id.nil?

    subtasks = SubTask.where(user_id: current_devise_api_user.id, task_id:)
    render json: subtasks
  end

  def mark_complete # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    sub_task = SubTask.find_by_id(params.dig(:data, :attributes, :sub_task_id))
    return render json: { error: 'not found' }, status: :not_found if sub_task.nil?

    return render json: { error: 'SubTask is already completed' }, status: :bad_request if sub_task.completed == true

    sub_task.update!(completed: true)
    all_subtask_completed = SubTask.where(task_id: sub_task.id).pluck(:completed).all?
    sub_task.task.update!(completed: true) if all_subtask_completed

    streak = Streak.find_by(user_id: current_devise_api_user.id)
    if streak.nil?
      Streak.create(user_id: current_devise_api_user.id, count: 1)
    else
      streak.increment
    end

    render json: { message: 'SubTask Marked Completed' }
  end

  def mark_incomplete
    sub_task = SubTask.find_by_id(params.dig(:data, :attributes, :sub_task_id))
    return render json: { error: 'not found' }, status: :not_found if sub_task.nil?

    if sub_task.completed == false
      return render json: { error: 'SubTask is already marked as not complete' },
                    status: :bad_request
    end

    sub_task.update!(completed: false)
    task = sub_task.task
    task.update!(completed: false) if task.completed == true
    render json: { message: 'SubTask Marked Incomplete' }
  end

  private

  def verify_ownership
    subtask = SubTask.find_by_id(params[:id])
    return true if subtask.nil?

    return render json: { error: 'no access' }, status: :unauthorized if subtask.user_id != current_devise_api_user.id # rubocop:disable Style/RedundantReturn
  end

  def verify_task_ownership
    task_id = params.dig(:data, :attributes, :task_id)
    task = Task.find_by(id: task_id, user_id: current_devise_api_user.id)
    return render json: { error: 'Task not found' } if task.nil?

    true
  end
end
