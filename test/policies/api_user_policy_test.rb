require "test_helper"
require "support/policy_helpers"

class ApiUserPolicyTest < ActiveSupport::TestCase
  include PolicyHelpers

  %i[new create index edit update revoke].each do |permission_name|
    context permission_name do
      should "allow only for superadmins" do
        assert permit?(create(:superadmin_user), User, permission_name)

        assert forbid?(create(:admin_user), User, permission_name)
        assert forbid?(create(:super_org_admin), User, permission_name)
        assert forbid?(create(:organisation_admin), User, permission_name)
        assert forbid?(create(:user), User, permission_name)
      end
    end
  end
end
