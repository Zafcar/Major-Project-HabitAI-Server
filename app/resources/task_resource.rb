class TaskResource < JSONAPI::Resource
  attributes :name, :completed, :user_id, :created_at, :description

  filter :created_at

  before_save do
    @model.user_id = context[:current_user].id if @model.new_record?
  end

  def self.creatable_fields(context)
    super - %i[user_id]
  end

  def self.updatable_fields(context)
    super - [:completed]
  end
end
