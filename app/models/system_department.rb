class SystemDepartment < ApplicationRecord
	belongs_to :department, :class_name => 'Department'
	belongs_to :system, :class_name => 'System'
	validate :duplicate_link

	def duplicate_link
		duplicate_link = SystemDepartment.where("system_id=? AND department_id=?", self.system_id, self.department_id) 
		if duplicate_link.exists?
			errors.add :base, 'System is already linked to this department.'
		end
	end
	
end
