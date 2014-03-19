class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :authorizable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
