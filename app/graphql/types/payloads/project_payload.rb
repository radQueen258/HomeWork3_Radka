module Types
  module Payloads
    class ProjectPayload < Types::BaseObject
      field :project, ProjectType, null: true
      field :id, ID, null: true
    field :name, String, null: false
    field :description, String, null: false

      field :errors, [Types::UserError], null: false
    end
  end
end
