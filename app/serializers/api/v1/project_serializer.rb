module Api
  module V1

  class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :created_at, :updated_at

  has_many :assignments, serializer: AssignmentSerializer
end
end
end
