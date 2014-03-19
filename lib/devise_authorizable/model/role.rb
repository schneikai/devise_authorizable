module DeviseAuthorizable
  module Model
    module Role
      extend ActiveSupport::Concern

      included do
        # Naming this +rolez+ because we want to have a +roles+ method that
        # returns a array of all assigned roles.
        has_many :rolez, as: :authorizable, dependent: :destroy, class_name: "DeviseAuthorizable::Role"
      end

      # Returns +true+ if the user is a guest. Otherwise +false+.
      def guest?
        !self.persisted?
      end

      # Returns +true+ if the user is signed in. Otherwise +false+.
      def authenticated?
        self.persisted?
      end

      # Returns all rolles.
      # Returns empty array if no roles exist.
      #
      #   @user.roles
      #   => [:admin, :moderator]
      #
      def roles
        system_roles | rolez.map{ |role| role.name }
      end

      # Returns +true+ if the given role exists otherwise +false+.
      # +name+ can be symbol or string.
      def has_role?(name)
        roles.include? to_role_name(name)
      end

      # Adds the given role if it does not already exist. Does not allow
      # to add system roles like <tt>:guest</tt> or <tt>:authenticated</tt>.
      # Returns the role name as symbol.
      # +name+ can be a symbol or string.
      def add_role(name)
        rolez.find_or_create_by!(name: name).name unless system_role?(name)
        to_role_name name
      end

      # Delete the given role.
      # Returns +true+ if the role was deleted +false+ if no such role existed
      # and therfore wasn't deleted.
      # Sytem roles like <tt>:guest</tt> and <tt>:authenticated</tt> cannot be deleted.
      # +name+ can be a symbol or string.
      def delete_role(name)
        rolez.where(name: name).destroy_all.any?
      end

      private
        # DeviseAuthorizable has two build in roles for +guest+ and +authenticated+
        # users. This method returns those roles for the current user.
        def system_roles
          roles = []
          roles << :guest if guest?
          roles << :authenticated if authenticated?
          roles
        end

        # Returns +true+ if the given role is a system role. Otherwise +false+.
        def system_role?(name)
          [:guest, :authenticated].include? to_role_name(name)
        end

        # All +role+ methods except the role name as string or symbol.
        # This method converts the name to a symbol if it is not a symbol.
        def to_role_name(name)
          if name.is_a? Symbol
            name
          else
            name.to_s.to_sym
          end
        end
    end
  end
end
