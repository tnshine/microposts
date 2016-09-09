class Micropost < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  paginates_per 5

  has_many :favorites
  has_many :favoriting_users, through: :favorites, source: :user

  has_many :reposts
  has_many :reposting_users, through: :reposts, source: :user
  
  belongs_to :reposts_microposts, class_name: 'Micropost', foreign_key: 'owner'

end
