# Feature: Sign in
#   As a user
#   I want to sign in
#   So I can visit protected areas of the site
feature 'Sign in', :devise do

  # Scenario: User cannot sign in if not registered
  #   Given I do not exist as a user
  #   When I sign in with valid credentials
  #   Then I see an invalid credentials message
  scenario 'user cannot sign in if not registered' do
    signin('test@example.com', 'please123')
    expect(page).to have_content I18n.t 'devise.failure.not_found_in_database', authentication_keys: 'Email'
  end

  # Scenario: User without api keys can sign in with valid credentials
  #   Given I exist as a user without an api key
  #   And I am not signed in
  #   When I sign in with valid credentials
  #   Then I am redirected to the tutorial section
  scenario 'user without api keys can sign in with valid credentials' do
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)
    expect(page.current_path).to eq(dashboard_tutorials_path)
  end

  # Scenario: User with api keys can sign in with valid credentials
  #   Given I exist as a user with an api key
  #   And I am not signed in
  #   When I sign in with valid credentials
  #   Then I am redirected to the dashboard section
  scenario 'user with api keys can sign in with valid credentials' do
    user = FactoryGirl.create(:user, client: FactoryGirl.create(:client))
    user.api_keys << FactoryGirl.create(:api_key)
    signin(user.email, user.password)
    expect(page.current_path).to eq(root_path)
  end

  # Scenario: User cannot sign in with wrong email
  #   Given I exist as a user
  #   And I am not signed in
  #   When I sign in with a wrong email
  #   Then I see an invalid email message
  scenario 'user cannot sign in with wrong email' do
    user = FactoryGirl.create(:user)
    signin('invalid@email.com', user.password)
    expect(page).to have_content I18n.t 'devise.failure.not_found_in_database', authentication_keys: 'Email'
  end

  # Scenario: User cannot sign in with wrong password
  #   Given I exist as a user
  #   And I am not signed in
  #   When I sign in with a wrong password
  #   Then I see an invalid password message
  scenario 'user cannot sign in with wrong password' do
    user = FactoryGirl.create(:user)
    signin(user.email, 'invalidpass')
    expect(page).to have_content I18n.t 'devise.failure.invalid', authentication_keys: 'Email'
  end

end
