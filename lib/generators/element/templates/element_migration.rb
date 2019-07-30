class Create<%= model.pluralize.underscore.camelize %> < ActiveRecord::Migration[6.0]
  def up
    create_table <%= ":#{model.pluralize.underscore}" %> do |t|

      t.string :name
      
      t.string :slug, unique: :true
      t.integer :status, default: 0
      t.integer :position
      t.timestamps
    end

    ControlRoom::Section.create(icon: 'cubes', title: "<%= model.pluralize.titleize %>", controller: "<%= model.pluralize.underscore %>")
  end

  def down
    ControlRoom::Section.find_by_title("<%= model.pluralize.titleize %>").destroy
    drop_table <%= ":#{model.pluralize.underscore}" %>
  end
end