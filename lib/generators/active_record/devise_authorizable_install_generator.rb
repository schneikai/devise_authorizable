require 'rails/generators/active_record'

module ActiveRecord
  module Generators
    class DeviseAuthorizableInstallGenerator < ActiveRecord::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      argument :name, type: :string, default: "DeviseAuthorizableRoles", desc: "The name of the roles table.", banner: "NAME"

      def create_migration
        migration_template "migration.rb", "db/migrate/create_#{table_name}"
      end
    end
  end
end
