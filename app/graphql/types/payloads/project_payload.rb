module Types
  module Payloads
    class ProjectPayload < Types::BaseObject
      field :project, ProjectType, null: true
      field :errors, [Types::UserError], null: false
    end
  end
end
