class User < ActiveRecord::Base

  validates :openid, presence: true
  validates :name,   presence: true

  enum provider: [:google_oauth2]
  enum role:     [:super_admin, :admin, :common]

  class << self

    def authenize(auth)
      provider = auth['provider']
      openid = auth['extra']['id_token'][0...64]

      locate_from_google(provider, openid) ||
        create_auth(provider, openid, auth)
    end

    def locate_from_google(provider, openid)
      User.where(provider: 'google_oauth2', openid: openid).first
    end

    def create_auth(provider, openid, auth)
      info = auth['info']
      name = info['name']
      email = info['email']
      avator = info['image']

      user = User.new(provider: provider,
                      openid: openid,
                      name: name,
                      email: email,
                      avator: avator)
      user.save
    end
  end

end
