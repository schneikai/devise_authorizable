module DeviseAuthorizable
  class Role < ActiveRecord::Base
    self.table_name = "devise_authorizable_roles"
    belongs_to :authorizable, polymorphic: true

    validates :authorizable, presence: true

    # Always return the role name as symbol.
    def name
      self[:name].to_sym
    end
  end
end
