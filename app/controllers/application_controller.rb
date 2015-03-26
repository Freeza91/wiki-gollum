# encoding: utf-8

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @current_user ||= User.where(id: session[:id]).first
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash['error'] = '没有权限'
    redirect_to root_path
  end

end
