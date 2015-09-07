class Admin::UsersController < Admin::ApplicationController

  def new
    @user = current_account.users.new
  end

  def create
    @user = current_account.users.new(user_params)
    if params[:user][:admin] == "1"
      @user.admin = true
    end

    if @user.save
      redirect_to admin_path, :notice => t('users.user_created')
    else
      render 'new'
    end
  end

  def edit
    @user = current_account.users.find(params[:id])
  end

  def update
    @user = current_account.users.find(params[:id])

    if @user.update(user_params)
      redirect_to edit_admin_user_path, :notice => t('users.user_updated')
    else
      render 'edit'
    end
  end

  def destroy
    @user = current_account.users.find(params[:id])
    @user.destroy

    redirect_to admin_path, :notice => t('users.user_deleted')
  end

  def show
    @user = current_account.users.find(params[:id])
    @entry_finder = Entry::Finder.new(finder_params)

    respond_to do |format|
      format.html
      format.pdf do
        send_pdf_data('entries/index.pdf.slim', 'report.pdf')
      end
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation, :admin, :language, :current_salary)
    end

    def finder_params
      params.permit(:project_id, :kind, :from, :to).merge(user: @user)
    end

end
