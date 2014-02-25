class SectionEdit < ActiveRecord::Base
  # attr_accessible :admin_user_id, :section_id, :summary,:editor,:section
  belongs_to :editor, :class_name =>"AdminUser",:foreign_key => "admin_user_id"
  belongs_to :section

  acts_as_list
  
end
