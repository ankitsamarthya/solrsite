class Subject < ActiveRecord::Base
   # attr_accessible :name, :position, :visible

   has_many :pages
   
   acts_as_list
   # 
   # ids, foriegn key, timstamps, booleans, counters
   validates_presence_of :name 
   validates_length_of :name , :maximum => 255
   # diff error msg "cant be blank" or "is to short"
   # 
  


   scope :visible, lambda {where(:visible => true)}
   scope :invisible, lambda {where(:visible => false)}
   scope :sorted, lambda {order("subjects.position ASC")}
   scope :newest_first, lambda {order("subjects.created_at DESC")}
   scope :search, lambda {|query|
   	where(["name LIKE ?","%#{query}%"])}

   searchable :auto_index=>true do 
      text :name , :as => :name_textp
      

   end
end
