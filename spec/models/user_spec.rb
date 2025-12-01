require 'rails_helper'

RSpec.describe User, type: :model do
  let(:creator) { create(:user) }
  let(:channel) { create(:channel, creator: creator) }
  let(:other_user) { create(:user) }

  # ---------------------------------------------------------------------------
  # Associations
  # ---------------------------------------------------------------------------
  describe "associations" do
    it { should have_many(:messages).dependent(:destroy) }
    it { should have_many(:memberships) }
    it { should have_many(:channels).through(:memberships) }
    it { should have_many(:created_channels).class_name("Channel").with_foreign_key("creator_id") }
  end

  # ---------------------------------------------------------------------------
  # Devise modules
  # ---------------------------------------------------------------------------
  describe "Devise modules" do
    it "responds to Devise methods" do
      expect(creator).to respond_to(:email, :password, :valid_password?)
      expect(creator).to respond_to(:remember_me)
    end
  end

  # ---------------------------------------------------------------------------
  # Method: admin?
  # ---------------------------------------------------------------------------
  describe "#admin?" do
    it "returns true if the user is an admin of the channel (creator)" do
      expect(creator.admin?(channel)).to eq(true)
    end

    it "returns false if the user is not an admin of the channel" do
      create(:membership, user: other_user, channel: channel, role: "member")
      expect(other_user.admin?(channel)).to eq(false)
    end
  end
end
