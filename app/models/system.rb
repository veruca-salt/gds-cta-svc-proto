class System < ApplicationRecord
	has_many :departments
	has_many :system_links
	has_many :system_departments
	#accepts_nested_attributes_for :system_departments
	validates :name, presence: true,
							length: { minimum: 2 }
	validates :acronymn, presence: true,
							length: { minimum: 2 },
							uniqueness: {
								message: ->(object, data) do 
									"#{data[:value]} is in use"									
								end
							}

	def System.top_ten!
		# refresh importance
		SystemLink.set_importance!
		# get the top ten most important systems by getting all systems
		# that have an importance value (minus nils), sorting then showing top 10
		@top_ten_results = System.where.not(importance: [nil, ""]) 

		@top_ten_results.order(importance: :desc).limit(10)
	end
end
