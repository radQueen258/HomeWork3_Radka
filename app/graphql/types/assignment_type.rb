module Types
  class AssignmentType < Types::BaseObject
    field :id, ID, null: true
    field :assignment_name, String, null: false
    field :description, String
    field :deadline, GraphQL::Types::ISO8601DateTime
    field :project_id, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :status, AssignmentStatusType, null: false
    field :project, ProjectType, null: false
  end
end
