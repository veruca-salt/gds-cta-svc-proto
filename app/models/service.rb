class Service < ApplicationRecord
	belongs_to :department, :class_name => 'Department'
	belongs_to :program, :class_name => 'Program'
	belongs_to :agency, :class_name => 'Agency'
	validates :name, presence: true,
							length: { minimum: 2 }
end
