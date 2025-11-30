class Channel < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :memberships
  has_many :users, through: :memberships
  belongs_to :creator, class_name: "User"

  validates :name, presence: true

  after_create :add_creator_as_admin

  scope :for_user, ->(user) {
    left_outer_joins(:memberships)
      .where("channels.public = ? OR memberships.user_id = ?", true, user.id)
      .distinct
  }

  def accessible_by?(user)
    public || users.exists?(user.id)
  end

  private
  def add_creator_as_admin
    memberships.create(user: creator, role: "admin")
  end
end
