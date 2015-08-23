module UserScope
  extend ActiveSupport::Concern
  included do
    scope :find_by_user, -> (user_id) { where(user_id: user_id) }
    belongs_to :user
    validates :user, presence: true
  end
end
