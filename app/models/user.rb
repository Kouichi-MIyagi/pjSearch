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
    return self.role == 'admin' ?  true : false;
  end
  
  def isAuthor?
    return !isAdmin?
  end
  
  # CSVアップロード
  def self.from_csv(anArray)
    u = new
    u.role  = 'author'
    u.email  = anArray[0]
    u.password  = anArray[1]
    u.user_name = anArray[2].to_s.encode('utf-8', 'sjis')
    u.recent_project = anArray[3].to_s.encode('utf-8', 'sjis')
    u.recent_customer = anArray[4].to_s.encode('utf-8', 'sjis')
	cu = Customer.where("csname = ?", u.recent_customer).first
	if !cu == nil 
	  u.customer_id = cu.id
	else
	  puts 'customer is nil !!'
	end
    u.user_id  = anArray[5]
	anArray[6].to_s == '1' ? u.resident = true : u.resident = false
	anArray[7].to_s.encode('utf-8', 'sjis') == '出向' ? u.transfferred = true : u.transfferred = false
    return u    	
  end  
end
