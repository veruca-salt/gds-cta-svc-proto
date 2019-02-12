class Department < ApplicationRecord
	has_many :services 
	has_many :systems
	has_many :system_departments
	validates :name, presence: true,
							length: { minimum: 2 },
							uniqueness: {
								message: ->(object, data) do 
									"#{data[:value]} is in use"									
								end
							}
	validates :description, presence: true,
							length: { minimum: 2 }


							
end
