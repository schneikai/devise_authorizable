module DeviseAuthorizable
  class Engine < ::Rails::Engine
    # We use to_prepare instead of after_initialize here because Devise is a
    # Rails engine and its classes are reloaded like the rest of the user's app.
    # Got to make sure that our methods are included each time.
    config.to_prepare do
      ::ActionController::Base.send :include, DeviseAuthorizable::Controller
    end
  end
end
