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

    @from = if params[:from].present?
              Date.parse(params[:from])
            else
              Date.new(Date.current.year, Date.current.month, 1)
            end

    @previous_month = (@from - 1.month).at_beginning_of_month
    @next_month = (@from + 1.month).at_beginning_of_month

    @entries = Entry.for_project(@project).between(@from, @next_month).by_date
    @total = @entries.sum(:minutes)
  end

  private

  def project_params
    params.require(:project).permit!
  end

end
