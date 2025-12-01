require 'rails_helper'

RSpec.describe Channel, type: :model do
  let(:creator) { create(:user) }
  let(:channel) { create(:channel, creator: creator) }

  # ---------------------------------------------------------------------------
  # Associations
  # ---------------------------------------------------------------------------
  describe "associations" do
    it { should have_many(:messages).dependent(:destroy) }
    it { should have_many(:memberships).dependent(:destroy) }
    it { should have_many(:users).through(:memberships) }
    it { should belong_to(:creator).class_name("User") }
  end

  # ---------------------------------------------------------------------------
  # Validations
  # ---------------------------------------------------------------------------
  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  # ---------------------------------------------------------------------------
  # Callback: add_creator_as_admin
  # ---------------------------------------------------------------------------
  describe "callbacks" do
    it "adds creator as admin membership after create" do
      channel
      membership = channel.memberships.find_by(user: creator)

      expect(membership).not_to be_nil
      expect(membership.role).to eq("admin")
    end
  end

  # ---------------------------------------------------------------------------
  # Scope: for_user
  # ---------------------------------------------------------------------------
  describe ".for_user" do
    let(:user) { create(:user) }

    it "returns public channels" do
      public_channel = create(:channel, public: true)
      expect(Channel.for_user(user)).to include(public_channel)
    end

    it "returns channels where the user is a member" do
      member_channel = create(:channel, public: false)
      create(:membership, channel: member_channel, user: user)

      expect(Channel.for_user(user)).to include(member_channel)
    end

    it "does NOT return private channels where user is not a member" do
      private_channel = create(:channel, public: false)
      expect(Channel.for_user(user)).not_to include(private_channel)
    end
  end

  # ---------------------------------------------------------------------------
  # Method: accessible_by?
  # ---------------------------------------------------------------------------
  describe "#accessible_by?" do
    let(:user) { create(:user) }

    it "returns true for public channels" do
      channel.update(public: true)
      expect(channel.accessible_by?(user)).to eq(true)
    end

    it "returns true if user is a member" do
      create(:membership, channel: channel, user: user)
      expect(channel.accessible_by?(user)).to eq(true)
    end

    it "returns false for private channels with no membership" do
      channel.update(public: false)
      expect(channel.accessible_by?(user)).to eq(false)
    end
  end
end
