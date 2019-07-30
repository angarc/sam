class CreateControlRoomSections < ActiveRecord::Migration[6.0]
  def change
    create_table :sections do |t|

      t.string :controller
      t.string :title
      t.string :icon

      t.timestamps
    end
  end
end
