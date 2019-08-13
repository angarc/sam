class BrandPlanCategory < ApplicationRecord
  extend FriendlyId
  friendly_id :category, use: :slugged
  # acts_as_list

  ADDABLE     = true
  EDITABLE    = true
  VIEWABLE    = false
  PUBLISHABLE = false
  DELETEABLE  = true

  belongs_to :blog

  enum status: [:unpublished, :published]

  default_scope { order(position: :asc) }

  def toggle_status
    if self.published?
      self.unpublished!
    else
      self.published!
    end
  end

  def label
    "#{category}"
  end

  def sublabel
    "Estimated # of Posts: #{estimated_number_of_possible_posts}"
  end

end
