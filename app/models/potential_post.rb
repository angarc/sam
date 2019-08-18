class PotentialPost < ApplicationRecord
  extend FriendlyId
  friendly_id :search_query, use: :slugged
  # acts_as_list

  enum will_create: [:no, :maybe, :yes, :added_to_hit_list]
  enum competition: [:zero, :low, :medium, :high, :extreme]

  ADDABLE     = true
  EDITABLE    = true
  VIEWABLE    = true
  PUBLISHABLE = false
  DELETEABLE  = true

  default_scope { order(created_at: :desc) }

  belongs_to :blog

  def label
    "#{search_query}"
  end

  def sublabel
    "Competition: <strong>#{competition.titleize}</strong> | Will You Create It? <strong>#{will_create.titleize}</strong>".html_safe
  end

end
