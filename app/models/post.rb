class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  # acts_as_list

  enum status: [:unwritten, :in_progress, :published]
  enum post_type: [:response, :staple, :pillar]

  scope :num_published, -> { where(status: :published).count }
  scope :posts_completed_for_type, -> (post_type) { where(post_type: post_type).count }
  scope :published_posts_old_in_months, -> (num){ where('date_published >= ? AND date_published <= ?', num.month.ago, (num - 1).month.ago).count }
  scope :published_posts_older_than_in_months, -> (num){ where('date_published <= ?', num.month.ago).count }

  default_scope { order(position: :asc) }

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

end
