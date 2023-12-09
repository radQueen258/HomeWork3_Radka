# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject

    field :project, resolver: Resolvers::Project
    field :projects, resolver: Resolvers::Projects

    field :assignment, resolver: Resolvers::Assignment
    field :assignments, resolver: Resolvers::Assignments

    # field :projects, [Types::ProjectType], null: false

    # def projects
    #   Project.all
    # end
  end
end
