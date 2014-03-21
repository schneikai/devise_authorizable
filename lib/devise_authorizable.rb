require 'devise'
require 'cancan'
require 'devise_authorizable/devise'

module DeviseAuthorizable
  autoload :VERSION, 'devise_authorizable/version'
  autoload :Controller, 'devise_authorizable/controller'

  module Model
    autoload :Role, 'devise_authorizable/model/role'
    autoload :Ability, 'devise_authorizable/model/ability'
  end
end

require 'devise_authorizable/engine'
