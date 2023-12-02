module Api
module V1
class AssignmentSerializer < ActiveModel::Serializer
  attributes :id, :assignment_name, :description, :deadline, :status

  attributes :deadline do
    object.deadline.strftime("%Y-%m-%d")
  end
end
end
end
