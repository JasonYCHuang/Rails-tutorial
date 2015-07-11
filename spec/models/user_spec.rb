describe User do

  before { @user = User.new(name: "Example User", email: "user@example.com", 
  							password: "foobarfoobar", password_confirmation: "foobarfoobar", remember_created_at: Time.now) }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_created_at) }
  it { should be_valid }
  it { should respond_to(:admin) }
  it { should respond_to(:microposts) }
  it { should respond_to(:microposts) }
  it { should respond_to(:feed) }
  it { should respond_to(:feed) }

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when password is not present" do
  	before do
  		@user = User.new(name: "Example User", email: "user@example.com",
  						 password: " ", password_confirmation: " ")
  	end
  	it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 7 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
  	before { @user.save }
  	let(:found_user) { User.find_by(email: @user.email) }

  	describe "with valid password" do
  	  # TBD
  	end

  	describe "with invalid password" do
  	  # TBD
    end
  end

  describe "remember token" do
    before { @user.save }
    it { expect(@user.remember_created_at).not_to be_blank }
  end

  describe "micropost associations" do

    before { @user.save }
    let!(:older_micropost) do
      FactoryGirl.create(:micropost, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_micropost) do
      FactoryGirl.create(:micropost, user: @user, created_at: 1.hour.ago)
    end

    it "should have the right microposts in the right order" do
      expect(@user.microposts.to_a).to eq [newer_micropost, older_micropost]
    end

    it "should destroy associated microposts" do
      microposts = @user.microposts.to_a
      @user.destroy
      expect(microposts).not_to be_empty
      microposts.each do |micropost|
        expect(Micropost.where(id: micropost.id)).to be_empty
      end
    end

    describe "status" do
      let(:unfollowed_post) do
        FactoryGirl.create(:micropost, user: FactoryGirl.create(:user))
      end
      let(:followed_user) { FactoryGirl.create(:user) }

      before do
        @user.follow(followed_user)
        3.times { followed_user.microposts.create!(content: "Lorem ipsum") }
      end

      it "should include proper micropost" do
        expect(subject.feed).to include(newer_micropost)
        expect(subject.feed).to include(older_micropost)
        expect(subject.feed).not_to include(unfollowed_post)
=begin
        its(:feed) do
          followed_user.microposts.each do |micropost|
            should include(micropost)
          end
        end
=end
      end

    end
  end

  it { should respond_to(:active_relationships) }
  it { should respond_to(:following) }
  it { should respond_to(:passive_relationships) }
  it { should respond_to(:followers) }

  it { should respond_to(:follow) }
  it { should respond_to(:unfollow) }

  describe "following" do
    let(:other_user) { FactoryGirl.create(:user) }
    before do
      @user.save
      @user.follow(other_user)
    end

    it { should be_following(other_user) }
    specify { expect(subject.following).to include(other_user) }

    describe "followed user" do
      subject { other_user }
      specify { expect(subject.followers).to include(@user) }
    end

    describe "and unfollowing" do
      before { @user.unfollow(other_user) }

      it { should_not be_following(other_user) }
      specify { expect(subject.following).not_to include(other_user) }
    end


  end



end