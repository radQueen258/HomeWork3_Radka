module Projects
  class DeletedProjectJob
    include Sidekiq::Worker

    sidekiq_options queue: :default, retry: 3

    def perform (project_id)
      project = Project.find_by(id: project_id)
    end
  end
end
