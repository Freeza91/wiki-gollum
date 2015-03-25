class WikisController < ApplicationController

  load_and_authorize_resource

  def index
    @wikis = Wiki::DATA.pages
  end

  def new
    @wiki = Wiki.new(name: 'Create A Wiki ')
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    commit = {
      name: @current_user,
      message: 'commit agagin',
      email: @current_user.email
    }
    if @wiki.update_attributes(params[:wiki], commit)
      redirect_to wiki_path(@wiki.name)
    else
      render :edit
    end
  end

  def create
    @wiki = Wiki.new(params[:wiki])
    commit = {
      name: @current_user,
      message: 'commit agagin',
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
      message: 'commit agagin',
      email: @current_user.email
    }
    @wiki.delete_page(@wiki.page, commit)
    redirect_to wikis_path
  end

end
