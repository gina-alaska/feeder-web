class Feed < ActiveRecord::Base
  validates :title, presence: true

  has_many :entries

  def preview
    entries.order(event_at: :desc).first
  end

  def helpers
    Rails.application.routes.url_helpers
  end
end
