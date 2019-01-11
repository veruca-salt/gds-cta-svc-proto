class Program < ApplicationRecord
	has_many :services 
	validates :name, presence: true,
							length: { minimum: 2 },
							uniqueness: {
								message: ->(object, data) do 
									"#{data[:value]} is in use"									
								end
							}
end
