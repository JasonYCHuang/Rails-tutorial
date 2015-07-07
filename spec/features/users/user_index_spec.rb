include Warden::Test::Helpers 
Warden.test_mode!

feature 'User index page', :devise do
	after(:each) do 
		Warden.test_reset!
	end


end