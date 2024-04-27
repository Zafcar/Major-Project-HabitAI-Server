class CreateStreaks < ActiveRecord::Migration[7.1]
  def change
    create_table :streaks do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :count, default: 0

      t.timestamps
    end
  end
end
