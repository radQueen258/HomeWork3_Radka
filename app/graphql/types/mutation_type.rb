# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_project, mutation: Mutations::CreateProject
    field :update_project, mutation: Mutations::UpdateProject
    field :delete_project, mutation: Mutations::DeleteProject

    field :create_assignment, mutation: Mutations::CreateAssignment
    field :update_comment, mutation: Mutations::UpdateComment
  end
end
