class Admin::AdminController < Admin::ApplicationController

  def index
    @projects = current_account.projects.all
    @users = current_account.users.all
  end

end
