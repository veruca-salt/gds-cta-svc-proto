class SystemLink < ApplicationRecord
	belongs_to :system_a, :class_name => 'System' 
	belongs_to :system_b, :class_name => 'System' 
	validates :system_a_id, :system_b_id, presence: true

# need validation to stop duplicates -- ?? add_index :system_links, [ :system_a_id, :system_b_id ], :unique => true

	attribute :weight, :integer, default: 1
	#attr_accessor :system_a, :system_b, :neighbors, :weights



	def SystemLink.generate_links!
		SystemLink.where("weight > 1").destroy_all # remove previously generated links beyond the immediate direct links
		SystemLink.where("weight = 1").find_each do |link|
			link!(link.system_a, link.system_b, link.weight) # start the regression
		end
	end


	def SystemLink.link!(sys_a, sys_b, weight, previous_links=[])
		return if sys_a == nil || sys_b == nil || weight > 4 # sanity checks
		new_weight = (weight + 1) # incremented weight for new links 
		# get all links from sys B excluding any links back to sys A
		SystemLink.where(["system_a_id = ? AND system_b_id <> ?", sys_b.id, sys_a.id]).find_each do |other_link|
			previous_links = previous_links << other_link
			been_linked_before = previous_links.any? { |prev_link| # searches a collection
				# sanity check to make sure we're not doubling back on ourself 
				# exclude first el check as it will always be the same
				return true if (prev_link.system_a_id == other_link.system_a_id && prev_link.system_b_id == other_link.system_b_id && previous_links.length > 1) || (prev_link.system_b_id == other_link.system_a_id && prev_link.system_a_id == other_link.system_b_id && previous_links.length > 1)
			}
			unless been_linked_before
				new_link = SystemLink.create(system_a_id: sys_a.id, system_b_id: other_link.system_b_id, weight: new_weight, protocol: "N/A")
				if new_link.save # no collision on validator 
					link!(new_link.system_a, new_link.system_b, new_link.weight) # continue the regression
				end
			end
		end 
	end

	def SystemLink.set_importance!
		# get all of system_a_id weights and add them up
		# save to system importance variable for the system id 
		System.update_all(importance: nil)  #first update importance col to nil for all

		SystemLink.where("weight = 1").find_each do |element|
			total_importance = 0 # always reset the variable for the next id

			SystemLink.where("system_a_id = ?", element.system_a_id).find_each do |syst|
				total_importance += syst.weight  # add up all the weights for this id
			end

			# save to system db - should this error check?
			thisSystem = System.find_by(id: element.system_a_id)
			thisSystem.update(importance: total_importance)
		end
	end
end

