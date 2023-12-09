module Types
  module Payloads
    class AssignmentPayload < Types::BaseObject
      field :assignment, AssignmentType, null: true
      field :errors, [Types::UserError], null: false
    end
  end
end
