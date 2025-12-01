require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:user) { create(:user) }
  let(:channel) { create(:channel) }
  let(:message) { create(:message, user: user, channel: channel, content: "Hello world!") }

  # ---------------------------------------------------------------------------
  # Associations
  # ---------------------------------------------------------------------------
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:channel) }
    it { should have_rich_text(:content) }
  end

  # ---------------------------------------------------------------------------
  # Validations
  # ---------------------------------------------------------------------------
  describe "validations" do
    it { should validate_presence_of(:content) }
  end

  # ---------------------------------------------------------------------------
  # Rich text content
  # ---------------------------------------------------------------------------
  describe "rich text content" do
    it "stores plain text correctly" do
      expect(message.content.to_plain_text).to eq("Hello world!")
    end
  end
end
