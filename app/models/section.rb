class Section < ActiveRecord::Base
   # attr_accessible :name, :position,:permalink,:page_id,:content_type,:content ,:editors
  has_many :section_edits
  has_many :editors, :through => :section_edits,:class_name =>"AdminUser"
  belongs_to :page

  acts_as_list
  
  CONTENT_TYPES =['text','HTML']

  validates_presence_of :name 
  validates_length_of :name , :maximum => 255
  validates_inclusion_of :content_type, :in => CONTENT_TYPES,:message => "must be one of :#{CONTENT_TYPES.join(', ')}" 
  validates_presence_of :content

   scope :visible, lambda {where(:visible => true)}
   scope :invisible, lambda {where(:visible => false)}
   scope :sorted, lambda {order("sections.position ASC")}
   scope :newest_first, lambda {order("sections.created_at DESC")}
   scope :search, lambda {|query|
   	where(["name LIKE ?","%#{query}%"])}

      searchable :auto_index=>true do 
      text :name , :as => :name_textp
      
   end
end
