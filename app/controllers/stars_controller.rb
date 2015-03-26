class StarsController < ApplicationController

  def index
    wiki_names = current_user.stars.map(&:wiki_name)
    @wikis = Wiki.where(name: wiki_names)
  end

  def star
    user = current_user
    star = Star.new(user_id: user.id, wiki_name: request.referer)
    count = 0
    msg = 'success'

    if user && valid?(request.referer) && star.save
      count = Star.where(wiki_name: request.referer).size
    else
      msg = 'error'
    end

    respond_to do |format|
      format.json { render json: { msg: msg, count: count } }
    end
  end

  def unstar
    user = current_user
    count = -1
    msg = 'success'

    if user && valid?(request.referer)
      star = Star.where(wiki_name: request.referer).first
      if star
        star.destroy
        count = Star.where(wiki_name: request.referer).size
      else
        msg = 'error'
      end
    else
      msg = 'error'
    end

    respond_to do |format|
      format.json { render json: { count: count, msg: msg } }
    end
  end

  private

  def valid?(url)
    url =~ /^https?:\/\/localhost:3000\/wikis\//
  end

end
