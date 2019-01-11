namespace :system_updater do

	task :update => :environment do
		puts "Generating links..."
		SystemLink.generate_links!

		puts "Setting importance..."
		SystemLink.set_importance!

		puts "Done"
	end
end
