class StarsController < ApplicationController

  def index
    wiki_names = current_user.stars.map(&:wiki_name)
    @wikis = Wiki.where(name: wiki_names)
  end

  def star
    user = current_user
    p params
    p user.id
    star = Star.new(user_id: user.id, wiki_name: params[:name])
    count = 0
    msg = 'success'

    if user && star.save
      count = Star.where(wiki_name: params[:name]).size
    else
      msg = 'error'
    end

    render json: { msg: msg, count: count }
  end

  def unstar
    user = current_user
    count = -1
    msg = 'success'

    if user
      star = Star.where(wiki_name: params[:name]).first
      if star
        star.destroy
        count = Star.where(wiki_name: params[:name]).size
      else
        msg = 'error'
      end
    else
      msg = 'error'
    end

    render json: { count: count, msg: msg }
  end

end
