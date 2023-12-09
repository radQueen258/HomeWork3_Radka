module Resolvers
  class Assignment < Resolvers::Base
    argument :id, ID, required: true

    type Types::AssignmentType, null: true

    def resolve(**options)
      ::Assignment.find_by(id: options[:id])
    end
  end
end
