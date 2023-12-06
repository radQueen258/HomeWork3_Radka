# frozen_string_literal: true

module Types
  class ProjectType < Types::BaseObject
    field :id, ID, null: true
    field :name, String, null: false
    field :description, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
