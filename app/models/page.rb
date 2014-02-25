class Page < ActiveRecord::Base
   # attr_accessible :name, :permalink ,:position ,:visible

  belongs_to :subject
  has_and_belongs_to_many :editors, :class_name =>"AdminUser"
  has_many :sections
  
  acts_as_list

  validates_presence_of :name 
  validates_length_of :name , :maximum => 255
  validates_presence_of :permalink 
  validates_length_of :permalink , :within => 3..255
  validates_uniqueness_of :name , :maximum => 255


   scope :visible, lambda {where(:visible => true)}
   scope :invisible, lambda {where(:visible => false)}
   scope :sorted, lambda {order("pages.position ASC")}
   scope :newest_first, lambda {order("pages.created_at DESC")}
   scope :search, lambda {|query|
   	where(["name LIKE ?","%#{query}%"])}

    searchable :auto_index=>true do 
      text :name ,:as => :name_textp
      integer :subject_id 
      
    end
  end
