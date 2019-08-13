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
  has_many :brand_plan_categories
  has_many :potential_posts
  has_one :statistic_overview

  default_scope { order(position: :asc) }

  def label
    "#{name}"
  end

  def sublabel
    ""
  end

  def writing_hours_left_on_hit_list
    pillar_hours = 0
    response_hours = 0
    staple_hours = 0
    self.posts.not_published.each do |post|
      response_hours += 1.5 if post.post_type == 'response'
      staple_hours += 3 if post.post_type == 'staple'
      pillar_hours += 4.5 if post.post_type == 'pillar'
    end
    total_hours = response_hours + staple_hours + pillar_hours

    { response: response_hours, staple: staple_hours, pillar: pillar_hours, total: total_hours }
  end

  def total_num_words_left_to_be_written
    num_words = 0
    self.posts.not_published.each do |post|
      num_words += 1350 if post.post_type == 'response'
      num_words += 2500 if post.post_type == 'staple'
      num_words += 3500 if post.post_type == 'pillar'
    end

    num_words
  end

  def num_potential_posts
    num = 0
    self.brand_plan_categories.each do |category|
      num += category.estimated_number_of_possible_posts
    end
    num
  end

  private
  def create_statistics_overview
    self.statistics_overview = StatisticOverview.create(blog_id: self.id)
  end

end
