class Admin::ProjectsController < Admin::ApplicationController

  def new
    @project = current_account.projects.new
  end

  def create
    @project = current_account.projects.new(project_params)

    if @project.save
      redirect_to admin_path, :notice => t('projects.project_created')
    else
      render :index
    end
  end

  def edit
    @project = current_account.projects.find(params[:id])
  end

  def update
    @project = current_account.projects.find(params[:id])

    if @project.update(project_params)
      redirect_to admin_path, :notice => t('projects.project_updated')
    else
      render 'edit'
    end
  end

  def destroy
    @project = current_account.projects.find(params[:id])
    @project.destroy

    redirect_to admin_path, :notice => t('projects.project_deleted')
  end

  def show
    @project = current_account.projects.find(params[:id])
    @entry_finder = Entry::Finder.new(finder_params)

    respond_to do |format|
      format.html
      format.pdf do
        send_pdf_data('entries/index.pdf.slim', 'report.pdf')
      end
    end
  end

  private

    def project_params
      params.require(:project).permit!
    end

    def finder_params
      params.permit(:user_id, :kind).merge(project: @project)
    end

end
