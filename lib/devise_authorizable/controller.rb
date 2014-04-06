module DeviseAuthorizable
  module Controller
    extend ActiveSupport::Concern
    # Creates and returns the current user's ability and caches it. If you
    # want to override how the Ability is defined then this is the place.
    # Just define the method in the controller to change behavior.
    #
    # Notice it is important to cache the ability object so it is not
    # recreated every time.
    #
    # TODO: The install generator by defaults creates the <tt>UserAbility</tt>
    # model and we return this for <tt>current_ability</tt>.
    # But if DeviseAuthorizable should work for different Devise models
    # this must be done somehow different...
    # Devise uses something like <tt>Devise::Mapping.find_scope!(record)</tt>
    # for example in <tt>devise_mail</tt> method.
    #
    def current_ability
      @current_ability ||= ::UserAbility.new(current_user)
    end
  end
end
