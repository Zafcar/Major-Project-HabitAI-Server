class User < ApplicationRecord
  devise :database_authenticatable, :api

  has_many :sub_tasks
  has_many :tasks
  has_one :streak
end
