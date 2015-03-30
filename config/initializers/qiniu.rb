require 'qiniu'

Qiniu.establish_connection! :access_key => Settings.access_key,
                            :secret_key => Settings.secret_key
