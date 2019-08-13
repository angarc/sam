class CreatePotentialPosts < ActiveRecord::Migration[6.0]
  def up
    create_table :potential_posts do |t|

      t.references :blog, index: true
      t.string :search_query
      t.integer :competition, default: 0
      t.integer :will_create, default: 0
      t.text :notes
      
      t.string :slug, unique: :true
      t.integer :status, default: 0
      t.integer :position
      t.timestamps
    end

    # ControlRoom::Section.create(icon: 'cubes', title: "Potential Posts", controller: "potential_posts")
  end

  def down
    # ControlRoom::Section.find_by_title("Potential Posts").destroy
    drop_table :potential_posts
  end
end