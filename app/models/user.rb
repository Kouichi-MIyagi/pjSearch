class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  # Change user_id etc. 2013/12/3 by Miyagi 
  attr_accessible :user_id, :email, :password, :password_confirmation, :remember_me, :user_id, :user_name, :customer_id, :user_access, :recent_project, :recent_customer, :recent_resident, :login

  # attr_accessible :title, :body
  
  # attr_accessor :login
  attr_accessible :login
  
  belongs_to :customer
  
  # user_id check by Miyagi 2013/12/4
  validates :user_id,
    :uniqueness => {
    :case_sensitive => false
    }

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(user_id) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  
end