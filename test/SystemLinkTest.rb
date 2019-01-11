class SystemLinkTest

	def initialize(sys1, sys2)
	    @sys1 = sys1
	    @sys2 = sys2
	    @adjacentNodes = []	
	    @weights = []
 	end

 	def displaySystemLink 
  		puts "testing.............: #{@sys1} -- #{@sys2}" 
	end	


	def createAdjArry

	end


	# TESTING
	#create new system link
	link1 = SystemLinkTest.new('1', '2')
	#run test
	link1.displaySystemLink


	require 'rgl/adjacency'
		graph = RGL::DirectedAdjacencyGraph.new
		graph.add_edge 1,2
		graph.add_edge 3,4
		graph.add_edge 1,4
		graph.add_edge 4,3

		require 'rgl/dot'
		graph.print_dotted_on



end