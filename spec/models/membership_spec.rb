require 'rails_helper'

RSpec.describe Membership, type: :model do
  let(:user) { create(:user) }
  let(:channel) { create(:channel) }

  # ---------------------------------------------------------------------------
  # Associations
  # ---------------------------------------------------------------------------
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:channel) }
  end

  # ---------------------------------------------------------------------------
  # Scopes
  # ---------------------------------------------------------------------------
  describe "scopes" do
    before do
      @admin_membership = create(:membership, :admin, user: user, channel: channel)
      @member_membership = create(:membership, role: "member", user: create(:user), channel: channel)
    end

    it "returns only admin memberships" do
      expect(channel.memberships.admins).to include(@admin_membership)
      expect(channel.memberships.admins).not_to include(@member_membership)
    end
  end
end
