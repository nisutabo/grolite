class TaskSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :group_id, :crop_id
end
