class WikisController < ApplicationController

  load_and_authorize_resource

  def index
    @wikis = Wiki::DATA.pages
  end

  def new
    @wiki = Wiki.new(name: '')
  end

  def show
    @wiki = Wiki.find(params[:id])
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

  def delete
    @wiki = Wiki.find(params[:id])
    commit = {
      name: @current_user,
      message: message,
      email: @current_user.email
    }
    page = Wiki::DATA.page(@wiki.name)
    @wiki.delete_page(page, commit)
    redirect_to wikis_path
  end

  def search
    Wiki.search(params[:q])
  end

  def message
    params['message'].present? ? "update #{@wiki.name}" : "#{params['message']}"
  end

end
