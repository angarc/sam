class CreateBlogSpreadsheetImports < ActiveRecord::Migration[6.0]
  def change
    create_table :blog_spreadsheet_imports do |t|

      t.references :blog
      t.datetime :started_processing
      t.datetime :finished_processing
      t.text :custom_errors
      t.timestamps
    end
  end
end
