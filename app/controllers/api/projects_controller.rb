module Api
  class ProjectsController < Api::ApplicationController
    def index
      render json: projects.to_json(json_format)
    end

    def show
      render json: project.to_json(json_format)
    end

    private

    def json_format
      {only: [:id, :name]}
    end

    def project
      @project ||= projects.find_by!(id: params[:id])
    end

    def projects
      @projects ||= current_user.projects
    end
  end
end
