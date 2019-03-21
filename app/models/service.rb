class Service < ApplicationRecord
	belongs_to :department, :class_name => 'Department'
	belongs_to :program, :class_name => 'Program', optional: true
	belongs_to :agency, :class_name => 'Agency', optional: true
	validates :name, presence: true, length: { minimum: 2 }, 
								uniqueness: {
								message: ->(object, data) do 
									"#{data[:value]} is in use"									
								end
							}
	validate :duplicate_service

	def duplicate_service
		duplicate_service = Service.where("name=? AND department_id=? AND program_id=? AND agency_id=?", self.name, self.department_id, self.program_id, self.agency_id) 
		if duplicate_service.exists?
			errors.add :base, 'Service already exists.'
		end
	end

end
