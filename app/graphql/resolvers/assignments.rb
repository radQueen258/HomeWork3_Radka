module Resolvers
  class Assignments < Resolvers::Base
    type [Types::AssignmentType], null: false

    def resolve(**_options)
      ::Assignment.all
    end
  end
end
