module Types
  class CommentType < Types::BaseObject
    field :id, ID, null: true
    field :content, String, null: false
    field :user_id, Integer, null: false
    field :assignment_id, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    # field :user, UserTy
    # field :assignment, AssignmentType, null: false
  end
end
