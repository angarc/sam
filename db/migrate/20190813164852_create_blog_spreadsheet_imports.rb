class CreateBlogSpreadsheetImports < ActiveRecord::Migration[6.0]
  def change
    create_table :blog_spreadsheet_imports do |t|

      t.references :blog

      t.timestamps
    end
  end
end
