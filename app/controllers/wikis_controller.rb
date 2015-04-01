class WikisController < ApplicationController

  load_and_authorize_resource

  def index
    @wikis = Wiki::DATA.pages
  end

  def new
    @wiki = Wiki.new(name: '' )
  end

  def show
    @wiki = Wiki.find(params[:id])
    @is_star = current_user.stars.map(&:wiki_name).include? @wiki.name
  end

  def update
    @wiki = Wiki.find(params[:id])
    commit = {
      name: @current_user.name,
      message: message,
      email: @current_user.email
    }
    if @wiki.update_attributes(@wiki, params[:wiki], commit)
      redirect_to wiki_path(@wiki.name)
    else
      render :edit
    end
  end

  def create
    @wiki = Wiki.new(params[:wiki])
    commit = {
      name: @current_user,
      message: message,
      email: @current_user.email
    }
    begin
      @wiki.save(commit)
      redirect_to wiki_path(@wiki.name)
    rescue Gollum::DuplicatePageError => e
      render :text => "Duplicate page: #{e.message}"
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    commit = {
      name: @current_user,
      message: "delete #{@wiki.name} wiki by #{@current_user.name}",
      email: @current_user.email
    }
    page = Wiki::DATA.page(@wiki.name)
    Wiki::DATA.delete_page(page, commit)
    redirect_to wikis_path
  end

  def search
    @wikis = Wiki.search(params[:q])
  end

  def message
    params['message'].present? ? "#{params['message']}" : "update #{@wiki.name}"
  end

end
