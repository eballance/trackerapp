module Api
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session
    before_filter :verify_token, :verify_user

    private

    def current_user
      @current_user ||= User.find_by!(token: token)
    rescue ActiveRecord::RecordNotFound
      head :unauthorized and return
    end
    alias_method :verify_user, :current_user

    def verify_token
      (head :bad_request and return) unless params[:token].present?
    end

    def token
      params[:token]
    end
  end
end
