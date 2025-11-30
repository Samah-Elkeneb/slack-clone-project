class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :channel

  enum role: {
    admin: "admin",
    member: "member"
  }

  scope :admins, -> { admin }
end
