class AddDueDateTimeToTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :dueDateTime, :datetime
  end
end
