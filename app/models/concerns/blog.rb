module Blog
  extend ActiveSupport::Concern

  included do
    scope :published, -> { where('published = :published AND
                            (publish_date <= :date OR publish_date is null)',
                            published: true, date: Date.today)
                              .order(publish_date: :desc)
                              .order(updated_at: :desc) }

    def main_image
      BlogImage.where(owner: self, main: true).first ||
          BlogImage.where(owner: self).first
    end
  end
end
