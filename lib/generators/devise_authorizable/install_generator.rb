module DeviseAuthorizable
  module Generators
    class InstallGenerator < Rails::Generators::NamedBase
      source_root File.expand_path("../templates", __FILE__)

      desc "Adds DeviseAuthorizable module, ability class and generate migrations."

      argument :name, type: :string, default: "User", desc: "The Devise model this module should be added to.", banner: "NAME"

      def add_module
        path = File.join("app", "models", "#{file_path}.rb")
        if File.exists?(path)
          inject_into_file(path, "authorizable, :", after: "devise :")
        else
          say_status "error", "Model not found. Expected to be #{path}.", :red
        end
      end

      def create_ability_class
        path = File.join("app", "models", "#{file_path}_ability.rb")
        template "ability.rb", path
      end

      hook_for :orm, as: :devise_authorizable_install
    end
  end
end
