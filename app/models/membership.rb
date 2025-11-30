class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :channel

  ROLES = %w[ admin member]

  validates :role, presence: true, inclusion: { in: ROLES }

  scope :admins, -> { where(role: "admin") }
end
