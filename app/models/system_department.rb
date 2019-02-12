class SystemDepartment < ApplicationRecord
	belongs_to :department, :class_name => 'Department'
	belongs_to :system, :class_name => 'System'

	# validation to stop duplicates - composite key?

	
end
