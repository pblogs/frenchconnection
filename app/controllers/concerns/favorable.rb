module Favorable
  extend ActiveSupport::Concern

  included do
    scope :favored_by, ->(user) { joins(:favorites)
      .where('favorites.user_id = ?', user.id) }

    def set_as_favorite
      Favorite.new(favorable: self)
    end
  end
end
