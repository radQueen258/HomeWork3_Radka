module Projects
  class CreateDefaultAssignmentsJob
    include Sidekiq::Worker

    sidekiq_options queue: :default, retry: 3
    def perform(project_id)
      Assignments::CreateDefault.call!(project_id: project_id )
    end
  end
end
