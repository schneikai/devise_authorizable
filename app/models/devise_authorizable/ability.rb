module DeviseAuthorizable
  class Ability
    include CanCan::Ability

    def initialize(authorizable)
      # Initialize a new +authorizable+ object if non was given so that this
      # works for guest users too. For example the Devise method +current_user+
      # wil return +nil+ if the user is not currently signed in.
      @authorizable = authorizable || authorizable.new

      create_authorizable_getter

      # Apply abilities for all other roles.
      apply_roles @authorizable.roles
    end

    # Methods for each role that exists in the application must be added to the
    # ability class in the application. Check the README under
    # "Managing Permission / Defining abilities." on how that works.

    private
      # This creates a instance method with the name of the +authorizable+ class
      # to allow access via the passed in object name instead of just <tt>@authorizable</tt>.
      # This is more comfortable when defining abilities because you can use
      # <tt>can [:update, :destroy], :all, user_id: user.id</tt> instead of
      # <tt> can [:update, :destroy], :all, user_id: @authorizable.id</tt>
      #
      #   ability = Ability.new(@user)
      #   ability.user
      #   => @user
      #
      #   ability = Ability.new(@foo)
      #   ability.foo
      #   => @foo
      #
      def create_authorizable_getter
        define_singleton_method(authorizable_getter_name) { @authorizable }
      end

      # Returns the name for the authorizable getter method.
      def authorizable_getter_name
        @authorizable.class.name.underscore
      end

      # Create abilities for each role in the given array.
      # This simply tries to call a method on the ability object with the same
      # name as the role. The role methods are called in the order they are
      # defined in the ability class. Remember to put low priority roles before
      # higher priority roles. This allows higher roles to overwrite behaviour
      # of lower roles.
      # https://github.com/ryanb/cancan/wiki/Ability-Precedence
      def apply_roles(roles)
        # If the user has the system role +authenticated+ include all
        # abilities for guest users too.
        self.try(:guest) if roles.include?(:authenticated)

        defined_roles.each do |role|
          self.try(role) if roles.include? role
        end
      end

      # Returns the roles methods defined on the ability object.
      # TODO: Couldn't find out if the order is always the order they are defined
      # in the class. Because this is really important. See commen on *apply_roles*.
      def defined_roles
        self.class.instance_methods(false)
      end
  end
end
