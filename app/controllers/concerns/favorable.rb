module Favorable
  extend ActiveSupport::Concern

  included do
    scope :favored_by, ->(user) { joins(:favorites)
      .where('favorites.user_id = ?', user.id) }

    def set_as_favorite
      Favorite.new(favorable: self)
    end

    def unset_favorite(user)
      Favorite.find_by(user_id: user.id, favorable: self).destroy
    end

    def is_favorite_of?(user)
      Favorite.where(user_id: user.id, favorable: self).exists?
    end
  end
end
