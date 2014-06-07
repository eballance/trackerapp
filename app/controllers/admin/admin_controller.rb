class Admin::AdminController < Admin::ApplicationController

  def index
    @projects = Project.all
    @users = current_account.users.all
  end

end
