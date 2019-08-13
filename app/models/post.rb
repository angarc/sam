class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  # acts_as_list

  enum status: [:unwritten, :in_progress, :published]
  enum post_type: [:response, :staple, :pillar]

  scope :more_recent_than,                     -> (time){ where('date_published >= ?', time) }
  scope :older_than,                           -> (time){ where('date_published <= ?', time) }
  scope :not_published,                        -> { where('status = 0 OR status = 1') }
  scope :posts_completed_for_type,             -> (post_type) { where(post_type: post_type, status: :published) }
  scope :posts_for_type,                       -> (post_type){ where(post_type: post_type) }
  scope :published_posts_old_in_months,        -> (num){ where('date_published >= ? AND date_published <= ?', num.month.ago, (num - 1).month.ago) }
  scope :published_posts_older_than_in_months, -> (num){ where('date_published <= ?', num.month.ago) }
  default_scope { order(position: :asc) }

  validates :blog, presence: true
  validates :category, presence: true
  validates :title, presence: true, uniqueness: true, length: { minimum: 5, maximum: 100 }

  ADDABLE     = true
  EDITABLE    = true
  VIEWABLE    = true
  PUBLISHABLE = false
  DELETEABLE  = true

  belongs_to :blog

  def label
    "#{title.titleize}"
  end

  def sublabel
    "#{blog.name} | <span class='badge badge-info'>#{post_type.titleize}</span> <span class='badge badge-primary'>#{status.titleize}</span>".html_safe
  end

  # -- CHAINED OR COMPLEX SCOPES -- 
  def self.incomplete_for_type(post_type)
    self.not_published.posts_for_type(post_type)
  end

    # older than time for type
  def self.not_published_for_type_and_older_than(time, post_type) 
    self.not_published.posts_for_type(post_type).older_than(time)
  end

  def self.order_of_priority(first = :response, second = :staple, third = :pillar)
    self.not_published.order("post_type = #{Post.post_types[first]} DESC, post_type = #{Post.post_types[second]} DESC, post_type = #{Post.post_types[third]} DESC").limit(5)
  end

end
