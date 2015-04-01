# Geek_Wiki

## Installation
```
  # clone repo
  git clone https://github.com/GeekPark/Geek_Wiki.git

  # Install dependencies
  cd Geek_Wiki
  bundle install

  # git init
  cd wiki
  git init

  # config/application.yml
  default: &default
    GOOGLE_CLIENT_ID: google-xx.apps.googleusercontent.com
    GOOGLE_CLIENT_SECRET: google-xx
    access_key: qiniu-xx
    secret_key: qiniu-xx
    super_admin:
      -
        email: email-xx
        provider: :google_oauth2
        openid: uuid-xx
        name: rudy
        role: :super_admin
        avator: https://lh3.googleusercontent.com/xx

  development:
    <<: *default

  production:
    <<: *default

  # rake db
  rake db:seed
  
```
## License

MIT
