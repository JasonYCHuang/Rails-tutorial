describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit new_user_session_path }

    it { should have_content('Log in') }
    it { should have_title('Log in') }
  end

  describe "signin" do
    before { visit new_user_session_path }

    describe "with invalid information" do
      before { click_button "Log in" }

      it { should have_title('Log in') }
      it { should have_selector('div.alert.alert-notification') }

      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-notification') }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email",    with: user.email.upcase
        fill_in "Password", with: user.password
        click_button "Log in"
      end

      it { should have_title(user.name) }
      it { should have_link('Profile',     href: user_path(user)) }
      it { should have_link('Log out',    href: destroy_user_session_path) }
      it { should_not have_link('Log in', href: new_user_session_path) }

      describe "followed by signout" do
        before { click_link "Log out" }
        it { should have_link('Log in') }
      end
    end
  end

end