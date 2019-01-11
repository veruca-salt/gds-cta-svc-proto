class DashboardController < ApplicationController
  def index
  	@systems = System.all
  	@top_ten_results = System.top_ten!
  end

  def refresh
  	SystemLink.generate_links!
	SystemLink.set_importance!

	flash[:notice] = 'System links regenerated' 
	redirect_to home_path
  end
end
