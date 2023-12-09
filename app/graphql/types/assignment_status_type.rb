module Types
  class AssignmentStatusType < Types::BaseEnum
    value "NOT_STARTED", value: "not_started", description: "Not_started"
    value "STARTED", value: "started", description: "Started"
    value "FINISHED", value: "finished", description: "Finished"
  end
end
