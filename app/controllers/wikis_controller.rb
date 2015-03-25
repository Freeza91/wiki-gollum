class WikisController < ApplicationController

  load_and_authorize_resource

  def index
    @wikis = Wiki::DATA.pages
  end

  def new
    @wiki = Wiki.new(name: 'hello hdfshifsdhisdfhisdf')
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    commit = {
      name: 'rudy',
      message: 'commit agagin ',
      email: '347212291@qq.com'
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
      name: 'rudy',
      message: 'commit agagin ',
      email: '347212291@qq.com'
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
      name: 'rudy',
      message: 'commit agagin ',
      email: '347212291@qq.com'
    }
    @wiki.delete_page(@wiki.page, commit)
    redirect_to wikis_path
  end

  def preview
    @body = params[:body]
    @content = Wiki::DATA.preview_page("Preview", @body, :markdown).formatted_data

    respond_to do |format|
      format.json
    end
  end

end
