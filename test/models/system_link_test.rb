require '../test_helper'

class SystemLinkTest < ActiveSupport::TestCase
   test "the truth" do
     assert true
   end

#create new system link
#link1 = SystemLink.new({system_a_id: '1', system_b_id: '2' })
#run test
#link1.displaySystemLink

puts "test......1 " 



link = SystemLink.new
link = SystemLink.first

puts "sys links........2 #{@system_links}"
		


SystemLink.all.each do |system_link|
	puts "test...........3 #{@system_link.system_a.acronymn}"

end



SystemLink.all.each do |system_link|
			puts "test......4 " 

		end



end
