class Message < ApplicationRecord
  include ActionText::Attachable

  has_rich_text :content
  belongs_to :user
  belongs_to :channel

  validates :content, presence: true
end
