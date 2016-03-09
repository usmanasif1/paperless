class User < ActiveRecord::Base
  # rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :phone
  
  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :orders
  has_many :folders
end
