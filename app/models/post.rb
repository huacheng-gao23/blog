class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title, presence: true
  validates :content, presence: true
  validates :category, presence: true, inclusion: { in: %w[news review] }

  before_save :calculate_reading_time

  scope :published, -> { where("published_at <= ?", Time.current) }
  scope :news, -> { where(category: "news") }
  scope :reviews, -> { where(category: "review") }

  def tag_list
    tags.split(",").map(&:strip) if tags.present?
  end

  def tag_list=(tags_string)
    self.tags = tags_string.split(",").map(&:strip).join(",")
  end

  def content
    markdown_content
  end

  def content=(text)
    self.markdown_content = text
  end

  private

  def calculate_reading_time
    words_per_minute = 200
    word_count = content.split.size
    self.reading_time = (word_count.to_f / words_per_minute).ceil
  end
end
