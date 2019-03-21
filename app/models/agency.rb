class Agency < ApplicationRecord
	has_many :services, dependent: :nullify 
	validates :name, presence: true,
							length: { minimum: 2 },
							uniqueness: {
								message: ->(object, data) do 
									"#{data[:value]} is in use"									
								end
							}
end
