class CreateControlRoomSections < ActiveRecord::Migration[6.0]
  def change
    create_table :control_room_sections do |t|

      t.string :controller
      t.string :title

      t.timestamps
    end
  end
end
