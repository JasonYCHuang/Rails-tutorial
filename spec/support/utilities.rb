include ApplicationHelper

def sign_in(user, options={})
	if options[:no_capybara]
		remember_created_at = Time.now
	    #cookies[:remember_created_at] = remember_created_at
	    user.update_attribute(:remember_created_at, remember_created_at)
  	else
	    visit new_user_session_path
	    fill_in "Email",    with: user.email
	    fill_in "Password", with: user.password
	    click_button "Log in"
	end
end