class CreatePosts < ActiveRecord::Migration[6.0]
  def up
    create_table :posts do |t|

      t.string     :category
      t.string     :primary_search_query
      t.string     :title
      t.integer    :title_length
      t.integer    :post_type, default: 0
      t.integer    :word_count
      t.date       :date_published
      t.references :blog, index: true
      
      t.string :slug, unique: :true
      t.integer :status, default: 0
      t.integer :position
      t.timestamps
    end

    # ControlRoom::Section.create(icon: 'sticky-note', title: "Histlists", controller: "posts")
  end

  def down
    # ControlRoom::Section.find_by_title("Histlists").destroy
    drop_table :posts
  end
end