# encoding: utf-8

module UsersHelper

  def select_options
    options =
      if can? :manage, User
        [['超级管理员', :super_admin], ['管理员', :admin], ['普通用户', :common]]
      elsif can? :cru, User
        [['管理员', :admin], ['普通用户', :common]]
      else
        [['普通用户', :common]]
      end
    end
end
