module Healthcheck
  class ApiTokens
    WARNING_THRESHOLD = 2.months.to_i
    CRITICAL_THRESHOLD = 1.month.to_i

    QUERY = <<-SQL.freeze
      SELECT tokens.resource_owner_id,
             tokens.application_id,
             tokens.expires_in
      FROM
        (
          SELECT resource_owner_id,
                 application_id,
                 revoked_at,
                 (oauth_access_tokens.expires_in -
                 (extract(epoch from now()) - extract(epoch from oauth_access_tokens.created_at))) as expires_in
          FROM oauth_access_tokens
        ) tokens
      INNER JOIN users ON users.id = tokens.resource_owner_id
      WHERE tokens.revoked_at IS NULL
      AND users.api_user = TRUE
      AND tokens.expires_in < #{WARNING_THRESHOLD}
    SQL

    def name
      :api_tokens
    end

    def message
      return "" unless expiring_tokens.any?

      "\n\n" + expiring_tokens.join("\n") + "\n\n"
    end

    def status
      return GovukHealthcheck::CRITICAL if expiring_tokens.any?(&:critical?)

      return GovukHealthcheck::WARNING if expiring_tokens.any?

      GovukHealthcheck::OK
    end

  private

    Record = Struct.new(:user_id, :application_id, :expires_in) do
      def critical?
        value_of(expires_in) < CRITICAL_THRESHOLD
      end

      def user
        User.find value_of(user_id)
      end

      def application
        Doorkeeper::Application.find value_of(application_id)
      end

      def expires_in_days
        (value_of(expires_in) / 1.day.to_i).round - 1
      end

      def to_s
        "#{user.name} token for #{application.name} expires in #{expires_in_days} days"
      end

      def value_of(obj)
        obj.is_a?(Array) ? obj.last : object_id
      end
    end

    def expiring_tokens
      @expiring_tokens ||= begin
        records = ActiveRecord::Base.connection.execute(QUERY)
        records.to_a.map { |raw_array| Record.new(*raw_array) }
      end
    end
  end
end
