class User < ActiveRecord::Base

  validates :openid, presence: true
  validates :name,   presence: true

  enum provider: [:google_oauth2]
  enum role:     [:super_admin, :admin, :common]

  has_many :stars, dependent: :destroy

  class << self

    def authenize(auth)
      provider = auth['provider']
      openid = auth['uid']
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
                      avator: avator,
                      role: :common)
      user.save
    end
  end

end
