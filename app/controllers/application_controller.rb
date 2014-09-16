class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def not_authenticated
    redirect_to login_url, :alert => t('common.must_login')
  end

  def current_account
    @current_account ||= current_user.account if current_user
  end

  before_filter :set_user_language
  helper_method :current_account

  private

    def set_user_language
      I18n.locale = current_user.language if logged_in?
    end

    def send_pdf_data(template, filename)
      html = render_to_string(template: template, layout: 'application.pdf.slim')

      pdfkit = PDFKit.new(html)
      pdfkit.stylesheets << Rails.root.join('vendor/assets/stylesheets/bootstrap.min.css')
      pdfkit.stylesheets << Rails.root.join('app/assets/stylesheets/pdf.css')

      send_data(pdfkit.to_pdf, filename: filename, type: 'application/pdf')
    end

end
