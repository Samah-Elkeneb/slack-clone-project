class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :messages, dependent: :destroy
  has_many :memberships
  has_many :channels, through: :memberships
  has_many :created_channels, class_name: "Channel", foreign_key: "creator_id"

  scope :not_in_channel, ->(channel) { where.not(id: channel.user_ids) }

  def admin?(channel)
    channel.memberships.admins.exists?(user: self)
  end
end
