class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  # acts_as_list

  enum status: [:unwritten, :in_progress, :published]
  enum post_type: [:response, :staple, :pillar]

  scope :published, -> { where(status: :published) }
  scope :not_published, -> { where('status = 0 OR status = 1') }
  scope :posts_completed_for_type, -> (post_type) { where(post_type: post_type, status: :published) }
  scope :posts_for_type, -> (post_type){ where(post_type: post_type) }
  scope :published_posts_old_in_months, -> (num){ where('date_published >= ? AND date_published <= ?', num.month.ago, (num - 1).month.ago) }
  scope :published_posts_older_than_in_months, -> (num){ where('date_published <= ?', num.month.ago) }

  default_scope { order(position: :asc) }

  attr_accessor :total_writing_hours

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

  # Chained complex scopes 

  def self.incomplete_for_type(post_type)
    self.not_published.posts_for_type(post_type)
  end


end
