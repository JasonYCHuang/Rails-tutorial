describe "User pages"  do

  subject { page }

  describe "signup page" do
    before { visit new_user_registration_path }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
  end

  describe "signup" do
    before { visit new_user_registration_path }

    let(:submit) { "Create my account" }
    let(:fillin_signup) {
    	  fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobarfoobar"
        fill_in "Password confirmation", with: "foobarfoobar"
    }

    describe "with valid information" do
      before { fillin_signup }

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }
        # TBD: After saving the user, the user haven't been logged in.
        #      Need to confirm account first.
        #it { should have_link('Log out') }
        #it { should have_title(user.name) }
        #it { should have_selector('div.alert.alert-info', text: 'Welcome') }
      end
    end

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "after saving the user" do
      before { fillin_signup }
      before { click_button submit }
      let(:user) { User.find_by(email: 'user@example.com') }
      # TBD: After saving the user, the user haven't been logged in.
      #      Need to confirm account first.

      #it { should have_title(user.name) }
      #it { should have_selector('div.alert.alert-info.alert-dismissible', text: 'Welcome') }
    end

    describe "after submission" do
      before { click_button submit }

      it { should have_title('Sign up') }
      it { should have_content('error') }
    end
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before do 
      sign_in user
      visit user_path(user) 
    end

    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_registration_path
    end

    describe "page" do
      it { should have_content("Update your profile") }
      it { should have_title("Edit user") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name",             with: new_name
        fill_in "Email",            with: new_email
        fill_in "Current password", with: user.password
        click_button "Save changes"
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-info') }
      it { should have_link('Log out', href: destroy_user_session_path) }
      specify { expect(user.reload.name).to  eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:m1) { FactoryGirl.create(:micropost, user: user, content: "Foo") }
    let!(:m2) { FactoryGirl.create(:micropost, user: user, content: "Bar") }

    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }

    describe "microposts" do
      it { should have_content(m1.content) }
      it { should have_content(m2.content) }
      it { should have_content(user.microposts.count) }
    end
  end
end
