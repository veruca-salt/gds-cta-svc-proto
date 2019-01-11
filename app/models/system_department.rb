class SystemDepartment < ApplicationRecord
	has_many :departments
	has_many :systems
	belongs_to :department, :class_name => 'Department'
	belongs_to :system, :class_name => 'System'

	# need validation to stop duplicates

	
end
