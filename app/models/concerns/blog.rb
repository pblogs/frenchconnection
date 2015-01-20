module Blog
  extend ActiveSupport::Concern

  included do
    scope :published, -> { where('published = :published and publish_date <=
                                :date', published: true, date: Date.today)
                          .order(publish_date: :desc).order(updated_at: :desc) }
  end
end
