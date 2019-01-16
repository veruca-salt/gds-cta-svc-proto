class DashboardController < ApplicationController
  before_action :authenticate_user!

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

  private
  def authenticate_user!
   redirect_to :login if current_user.nil?
  end
end
