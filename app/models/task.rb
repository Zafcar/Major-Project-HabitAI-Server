class Task < ApplicationRecord
  has_many :sub_tasks, dependent: :destroy
  belongs_to :user

  validates_presence_of :name
end
