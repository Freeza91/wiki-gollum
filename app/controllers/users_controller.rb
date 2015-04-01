# encoding: utf-8
require 'qiniu'

class UsersController < ApplicationController

  load_and_authorize_resource only: [:delete, :index, :update]

  def home
    if current_user
      flash[:notice] = '已经登录'
      redirect_to wikis_path
    end
  end

  def index
    @users = User.all
  end

  def update
    msg = 'error'
    user = User.find(params[:id])
    msg = 'success' if user && user.update_attributes(role: params[:role].to_sym)

    render json: { msg: msg}
  end

  def callback
    auth = JSON.parse(request.env["omniauth.auth"].to_json)
    @current_user = User.authenize(auth)
    if current_user
      session[:id] = @current_user.id
      flash['notice'] = '成功登陆'
      redirect_to wikis_path
    else
      flash['error'] = '用户名或密码不正确'
      redirect_to root_path
    end
  end

  def delete
    reset_session
    flash['notice'] = '成功登出'
    redirect_to root_path
  end

  def upload
    put_policy = Qiniu::Auth::PutPolicy.new(bucket: 'geekpark-wiki',
                                            key: key)
    uptoken = Qiniu::Auth.generate_uptoken(put_policy)

    render json: { upload_token: uptoken }
  end

  private

  def key
    require 'SecureRandom'
    hex = SecureRandom.hex[0..8]
    Time.now.to_i.to_s + hex + '.jpg'
  end

end
