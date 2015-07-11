require 'rails_helper'
=begin
RSpec.describe Relationship, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
=end

describe Relationship do

  let(:follower) { FactoryGirl.create(:user) }
  let(:followed) { FactoryGirl.create(:user) }
  let(:active_relationships) { follower.active_relationships.build(followed_id: followed.id) }

  subject { active_relationships }

  it { should be_valid }
  describe "follower methods" do
    it { should respond_to(:follower) }
    it { should respond_to(:followed) }
    specify { expect(subject.follower).to eq follower }
    specify { expect(subject.followed).to eq followed }
  end

  describe "when followed id is not present" do
    before { active_relationships.followed_id = nil }
    it { should_not be_valid }
  end

  describe "when follower id is not present" do
    before { active_relationships.follower_id = nil }
    it { should_not be_valid }
  end
end
