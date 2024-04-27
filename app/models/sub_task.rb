class SubTask < ApplicationRecord
  belongs_to :task
  belongs_to :user

  validates_presence_of :name

  after_create :mark_task_incomplete

  def mark_task_incomplete
    task = Task.find_by(id: task_id)
    task.update!(completed: false) if task.completed == true
  end
end
