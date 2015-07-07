# Feature: Sign in
#   As a user
#   I want to log in
#   So I can visit protected areas of the site
feature 'Log in', :devise do

  # Scenario: User cannot log in if not registered
  #   Given I do not exist as a user
  #   When I log in with valid credentials
  #   Then I see an invalid credentials message
  scenario 'user cannot log in if not registered' do
    login('test@example.com', 'please123')
    expect(page).to have_content I18n.t 'devise.failure.not_found_in_database', authentication_keys: 'email'
  end

  # Scenario: User can log in with valid credentials
  #   Given I exist as a user
  #   And I am not log in
  #   When I log in with valid credentials
  #   Then I see a success message
  scenario 'user can log in with valid credentials' do
    user = FactoryGirl.create(:user)
    login(user.email, user.password)
    expect(page).to have_content I18n.t 'devise.sessions.signed_in'
  end

  # Scenario: User cannot log in with wrong email
  #   Given I exist as a user
  #   And I am not log in
  #   When I log in with a wrong email
  #   Then I see an invalid email message
  scenario 'user cannot log in with wrong email' do
    user = FactoryGirl.create(:user)
    login('invalid@email.com', user.password)
    expect(page).to have_content I18n.t 'devise.failure.not_found_in_database', authentication_keys: 'email'
  end

  # Scenario: User cannot log in with wrong password
  #   Given I exist as a user
  #   And I am not log in
  #   When I log in with a wrong password
  #   Then I see an invalid password message
  scenario 'user cannot log in with wrong password' do
    user = FactoryGirl.create(:user)
    login(user.email, 'invalidpass')
    expect(page).to have_content I18n.t 'devise.failure.invalid', authentication_keys: 'email'
  end

end