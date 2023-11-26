module Assignments
  class UpdatedAssignmentJob
    include Sidekiq::Worker

    # sidekiq_options queue: :default, retry: 3

    def perform (assignment_id)
      assignment = Assignment.find_by(id: assignment_id)
    end

  end
end
