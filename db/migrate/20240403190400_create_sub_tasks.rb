class CreateSubTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :sub_tasks do |t|
      t.string :name
      t.boolean :completed, default: false
      t.references :task
      t.references :user

      t.timestamps
    end
  end
end
