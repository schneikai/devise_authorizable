module DeviseAuthorizable
  module Model
    module Ability
      extend ActiveSupport::Concern

      included do
        delegate :can?, :cannot?, to: :ability
      end

      # Returns a instance of the ability class for the current model.
      def ability
        @ability ||= ability_class.new(self)
      end

      private
        # Returns the ability class for the current model.
        def ability_class
          "#{self.class.name}Ability".constantize
        end
    end
  end
end
