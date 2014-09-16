class EntriesController < ApplicationController
  before_filter :require_login

  def index
    @entry_finder = Entry::Finder.new(finder_params)
    @entry_form ||= EntryForm.new(current_user)

    respond_to do |format|
      format.html
      format.pdf do
        send_pdf_data('entries/index.pdf.slim', 'report.pdf')
      end
    end
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

    def finder_params
      params.permit(:project_id, :kind).merge(user: current_user)
    end

end
