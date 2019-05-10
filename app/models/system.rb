class System < ApplicationRecord
	has_many :departments
	has_many :system_links, foreign_key: 'system_a_id', dependent: :destroy, inverse_of: :system_a
	has_many :system_departments
	accepts_nested_attributes_for :system_departments, allow_destroy: true
	accepts_nested_attributes_for :system_links, allow_destroy: true
	validates :name, presence: true,
							length: { minimum: 2 }
	validates :acronymn, presence: true,
							length: { minimum: 2 },
							uniqueness: {
								message: ->(object, data) do 
									"#{data[:value]} is in use"									
								end
							}

	after_save :save_links!


	def System.top_ten!
		# refresh importance
		SystemLink.set_importance!
		# get the top ten most important systems by getting all systems
		# that have an importance value (minus nils), sorting then showing top 10
		@top_ten_results = System.where.not(importance: [nil, ""]) 

		@top_ten_results.order(importance: :desc).limit(10)
	end

	def save_links!
		#raise "Thou shalt not pass!"
		 self.system_links.each do |link|
		 	link.system_a_id = self.id
		 	link.save!
		 end
	end
end
