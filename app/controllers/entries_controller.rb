class EntriesController < ApplicationController
  before_filter :require_login

  def index
    @from = if params[:from].present?
              Date.parse(params[:from])
            else
              (Date.current - 2.months).at_beginning_of_month.to_date
            end
    @to =   if params[:to].present?
              Date.parse(params[:to])
            else
              Date.current
            end

    @entries = Entry.for_user(current_user).between(@from, @to).by_date

    if params[:project_id].present?
      @entries = @entries.for_projects([params[:project_id]])
      @project = Project.find(params[:project_id])
    end

    @total = @entries.sum(:minutes)

    @entry_form ||= EntryForm.new(current_user)

  end

  def new
    @entry_form = EntryForm.new(current_user)
  end

  def create
    @entry_form = EntryForm.new(current_user, entry_form_params)
    if @entry_form.submit
      redirect_to entries_path, notice: t('entries.entry_created')
    else
      index
      render :index
    end
  end

  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy

    redirect_to root_path, notice: t('entries.entry_deleted')
  end

  private
    def entry_form_params
      params.require(:entry_form).
        permit(:description, :date, :time_spent, :project_id, :links).
        merge(user_id: current_user.id)
    end

end
