class CreateBlogs < ActiveRecord::Migration[6.0]
  def up
    create_table :blogs do |t|
      t.references :user, index: true
      t.string :name
      t.references :statistic_overview
      
      t.string :slug, unique: :true
      t.integer :status, default: 0
      t.integer :position
      t.timestamps
    end

    ControlRoom::Section.create(icon: 'newspaper', title: "My Blogs", controller: "blogs")
  end

  def down
    ControlRoom::Section.find_by_title("My Blogs").destroy
    drop_table :blogs
  end
end