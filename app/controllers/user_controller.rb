class UserController < ApplicationController

  def home
  end

  # return
  # access_type=offline
  # state=54ae4b9482ae66a0ea0f281aae0cb56025d402aeb27a0e15
  # client_id=1040280098498-b8q88oc6cbfibsv5qj8v7t3ngv40ctts.apps.googleusercontent.com
  # hl=zh-CN
  # from_login=1
  # as=313482f5933021ce
  def callback
    render text: 'successful auth'
  end

end
