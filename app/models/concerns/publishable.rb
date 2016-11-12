module Publishable
  extend ActiveSupport::Concern

  included do
    attr_accessor :published
    before_save :set_published_status

    def set_published_status
      return if published.nil?

      if published
        self.published_at ||= Time.now
      elsif !published
        self.published_at = nil
      end
    end

    # Filters
    scope :published,   -> () { where.not(published_at: nil) }
    scope :unpublished, -> () { where(published_at: nil) }
    scope :find_by_published_status, -> (status) {
      status.in?(["published", "unpublished"]) ? send(status) : all
    }

    def published?
      !!published_at
    end

    def published_status
      published? ? :published : :unpublished
    end
  end
end
