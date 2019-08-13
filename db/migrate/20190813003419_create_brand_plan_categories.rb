class CreateBrandPlanCategories < ActiveRecord::Migration[6.0]
  def up
    create_table :brand_plan_categories do |t|

      t.references :blog, index: true
      t.string :category
      t.integer :estimated_number_of_possible_posts
      
      t.string :slug, unique: :true
      t.integer :status, default: 0
      t.integer :position
      t.timestamps
    end
  end

  def down
    drop_table :brand_plan_categories
  end
end