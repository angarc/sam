class StatisticOverview < ApplicationRecord
  extend FriendlyId
  friendly_id :label, use: :slugged
  # acts_as_list

  ADDABLE     = false
  EDITABLE    = false
  VIEWABLE    = false
  PUBLISHABLE = false
  DELETEABLE  = false

  enum status: [:unpublished, :published]

  default_scope { order(position: :asc) }

  belongs_to :blog

  def toggle_status
    if self.published?
      self.unpublished!
    else
      self.published!
    end
  end

  def label
    "Statistics Overview"
  end

  def sublabel
    ""
  end

end
