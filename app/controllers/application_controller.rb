class ApplicationController < ActionController::Base
  include SessionsHelper
  include AdminHelper

  before_action :set_locale

  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  def handle_record_not_found
    flash[:danger] = t ".not_found"
    redirect_to root_path
  end

  rescue_from CanCan::AccessDenied do
    redirect_to home_path, flash: {danger: t("application.action_not_allowed")}
  end

  private
  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    check = I18n.available_locales.include?(locale)
    I18n.locale = check ? locale : I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end
end
