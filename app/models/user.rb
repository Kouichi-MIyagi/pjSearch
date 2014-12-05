class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  # Change user_id etc. 2013/12/3 by Miyagi 
  #attr_accessible :email, :password, :password_confirmation, :remember_me, :user_id, :user_name, :customer_id,
  #  :user_access, :recent_project, :recent_customer, :recent_resident, :resident, :transfferred, :request_questionnaire_id, :resident_email
  # , :login

   
  belongs_to :customer
  belongs_to :request_questionnaire
  has_many :questionnaires, :through => :request_questionnaires
  has_many :user_states, ->{order("target_year DESC  , target_month DESC") }, dependent: :destroy
#  has_many :user_states, :order => 'target_year DESC , target_month DESC', :dependent => :destroy
  has_many :responses, :dependent => :destroy

  # attr_accessible :login
  
  #attr_accessible :role
  ROLES=%w[admin author]
  
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
    csv_id = anArray[8]
	if csv_id.size < 7
       csv_id = "%07d" % anArray[8]
    end	
  	p_id = 'p'.concat(csv_id)
	
    u = User.find_by_user_id(p_id) || new(:role => 'author', :password => anArray[0].downcase,
											:user_id => p_id)
    u.email  = anArray[0]
	anArray[4] == '出向' ? u.transfferred = true : u.transfferred = false
    u.user_name = anArray[7]
	anArray[9].to_s == '1' ? u.resident = true : u.resident = false
    u.recent_customer = anArray[12]
    return u 
  end
  
  def targetUserState(targetYear,targetMonth)
    return UserState.where(:user_id => self.id).where(:target_year => targetYear).where(:target_month => targetMonth).first
  end
  
  def myMailAddress
    if self.resident_email.blank? 
	  return self.email
	else
	  return self.email + ';' + self.resident_email
	end
  end
  
  def asTimelineRows
    anArray = Array.new()
    self.user_states.each do | anUserState |
      anArray.push(anUserState.asTimelineRow)
    end
    return anArray
  end

end
