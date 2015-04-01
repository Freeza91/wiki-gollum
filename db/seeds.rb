#super_admin

admins = Settings.super_admin
admins.each do |admin|
  User.create(email: admin.email,
              provider: admin.provider.to_sym,
              openid: admin.openid,
              name: admin.name,
              role: admin.role.to_sym,
              avator: admin.avator)
end
