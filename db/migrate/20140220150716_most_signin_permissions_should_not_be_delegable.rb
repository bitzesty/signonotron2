class MostSigninPermissionsShouldNotBeDelegable < ActiveRecord::Migration[5.1][5.0]
  def up
    require "enhancements/application.rb"

    Doorkeeper::Application.where("name not in ('Content Planner', 'Support')").each do |application|
      application.signin_permission.tap { |p| p.delegatable = false }.save
    end
  end
end
