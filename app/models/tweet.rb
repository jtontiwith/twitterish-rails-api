class Tweet < ApplicationRecord
  belongs_to :user
  scope :authored_by, ->(username) { where(user: User.where(username: username)) }
  validates :body, presence: true, allow_blank: false
  validates :slug, uniqueness: true, exclusion: { in: ['feed'] }

  before_validation do
    self.slug ||= "#{body.to_s.parameterize}-#{rand(36**6).to_s(36)}"
  end
end
