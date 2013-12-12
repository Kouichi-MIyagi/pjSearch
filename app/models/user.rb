class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  # Change user_id etc. 2013/12/3 by Miyagi 
  attr_accessible :email, :password, :password_confirmation, :remember_me, :user_id, :user_name, :customer_id,
    :user_access, :recent_project, :recent_customer, :recent_resident, :resident, :transfferred, :request_questionnaire_id
  # , :login

  # attr_accessible :title, :body
   
  belongs_to :customer
  belongs_to :request_questionnaire
  has_many :questionnaires, :through => :request_questionnaires

  # attr_accessible :login
  attr_accessible :login
  
  attr_accessible :role
  ROLES=%w[admin author]

  belongs_to :customer
  
  # user_id check by Miyagi 2013/12/4
  validates :user_id,
    :uniqueness => {
    :case_sensitive => false
    }

  # def self.find_first_by_auth_conditions(warden_conditions)
  #   conditions = warden_conditions.dup
  #   if login = conditions.delete(:login)
  #     where(conditions).where(["lower(user_id) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  #   else
  #     where(conditions).first
  #   end
  # end
  
  def requested?
    return !(self.request_questionnaire.nil?)
  end
  
  def isAdmin?
    #roleで判断するよう修正要（とりあえず常駐でもなく、出向している人以外は管理者とみなす）
    return !(self.resident || self.transfferred)
  end
  
end
