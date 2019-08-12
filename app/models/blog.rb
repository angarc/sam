class Blog < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  after_create :create_statistic_overview

  # acts_as_list

  ADDABLE     = true
  EDITABLE    = true
  VIEWABLE    = true
  PUBLISHABLE = false
  DELETEABLE  = true

  has_many :posts
  has_one :statistic_overview

  default_scope { order(position: :asc) }

  def label
    "#{name}"
  end

  def sublabel
    ""
  end

  def create_statistics_overview
    self.statistics_overview = StatisticOverview.create(blog_id: self.id)
  end

end
