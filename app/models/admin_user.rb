class AdminUser < ActiveRecord::Base
   # attr_accessible :first_name, :last_name, :username,:email,:hashed_password, :sections
   # To configure a different table name:
   # self.table_name = "admin_users"

  has_secure_password

  has_and_belongs_to_many :pages 
  has_many :section_edits
  has_many :sections, :through => :section_edits

  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i
  FORBIDDEN_USERNAMES=['shubhamkedia','admin','maryjane']
  # validates_presence_of :first_name
  # validates_length_of :first_name, :maximum => 25
  # validates_presence_of :last_name
  # validates_length_of :last_name, :maximum => 50
  # validates_presence_of :username
  # validates_length_of :username, :within => 8..25
  # validates_uniqueness_of :username
  # validates_presence_of :email
  # validates_uniqueness_of :email
  # validates_length_of :email, :maximum => 100
  # validates_format_of :email, :with => EMAIL_REGEX
  # validates_confirmation_of :email

  # Shortcut validations
  validates :first_name, :presence => true, 
                         :length => {:maximum => 25}
  validates :last_name, :presence => true,
                         :length => {:maximum => 25}
  validates :username, :presence => true, 
                       :length => {:within => 8..25}, 
                       :uniqueness => true
  validates :email, :presence => true, 
                    :length => {:maximum => 100},
                    :uniqueness => true,
                    :format => EMAIL_REGEX,
                    :confirmation => true
  validate :username_is_allowed
  # validate :no_users_wednesday, :on => :create

  scope :sorted_first_name, lambda {order("admin_users.first_name ASC")}
  scope :sorted_last_name, lambda {order("admin_users.last_name ASC")}
  scope :sorted_by_id, lambda {order("admin_users.id ASC")}
  scope :sorted, lambda {order("last_name ASC,first_name ASC")}

  def name
    "#{first_name} #{last_name}"
  end

  def username_is_allowed
    if FORBIDDEN_USERNAMES.include?(username)
      errors.add(:username,"has been restricted from use.")
    end 
  end

  def no_users_wednesday
    if Time.now.wday == 3
      errors[:base] << "No new Users on Wednesday"
    end
  end
end
