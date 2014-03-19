module Devise
  module Models
    module Authorizable
      extend ActiveSupport::Concern

      included do
        include DeviseAuthorizable::Model::Role
        include DeviseAuthorizable::Model::Ability
      end
    end
  end
end
