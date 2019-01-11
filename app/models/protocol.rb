class Protocol < ApplicationRecord
	validates :name, presence: true,
							length: { minimum: 2 },
							uniqueness: {
								message: ->(object, data) do 
									"#{data[:value]} is in use"									
								end
							}
end
