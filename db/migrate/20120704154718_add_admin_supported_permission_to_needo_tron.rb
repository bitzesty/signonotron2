class AddAdminSupportedPermissionToNeedoTron < ActiveRecord::Migration[5.1][5.0]
  class SupportedPermission < ActiveRecord::Base
    belongs_to :application, class_name: 'Doorkeeper::Application'
  end

  def change
    needotron = ::Doorkeeper::Application.find_by_name("Need-o-Tron")
    if needotron
      SupportedPermission.create!(application: needotron, name: "admin")
    end
  end
end
