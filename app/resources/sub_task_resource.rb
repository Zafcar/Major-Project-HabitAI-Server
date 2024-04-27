class SubTaskResource < JSONAPI::Resource
  attributes :name, :completed, :user_id, :task_id, :created_at

  filter :created_at

  before_save do
    @model.user_id = context[:current_user].id if @model.new_record?
  end

  def self.creatable_fields(context)
    super - %i[user_id]
  end

  def self.updatable_fields(context)
    super - %i[completed task_id]
  end
end
