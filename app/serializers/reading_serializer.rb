class ReadingSerializer < ActiveModel::Serializer
  attributes :id, :group_id, :user_id, :ph, :ec, :date
end
