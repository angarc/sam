class BlogSpreadsheetImport < ApplicationRecord
  belongs_to :blog
  has_one_attached :spreadsheet, dependent: :destroy

  def self.process_spreadsheets
    BlogSpreadsheetImport.where(started_processing: nil).each do |import|
      import.started_processing = DateTime.now
      import.save
      blog = import.blog
      xlsx = Roo::Spreadsheet.open(Rails.application.routes.url_helpers.url_for(import.spreadsheet), { expand_merged_ranges: true })
      # puts xlsx.info

      # Brand Plan
      brand_array = xlsx.sheet(1).parse(headers: true)
      
      brand_array[1..-1].each do |row|
        brand_plan_category = BrandPlanCategory.create(
          blog_id: blog.id,
          category: row["Category"],
          estimated_number_of_possible_posts: row["Estimated Number of Possible Posts"]
        )
      end

      # Ideation and Selection
      ideation_array = xlsx.sheet(2).parse(headers: true)
      # puts ideation_array
      ideation_array[1..-1].each do |row|
        post = PotentialPost.create(
          blog_id: blog.id,
          search_query: row["Search Query"],
          competition: row["Competition"].titleize.gsub(' ', '').underscore,
          will_create: row["Will You Create the Content?"].titleize.gsub(' ', '').underscore,
          notes: row["Notes"]
        )
      end

      hit_list = xlsx.sheet(3)
      hit_list = hit_list.parse(headers: true)
      hit_list[1..-1].each do |row|
        begin
          post = Post.create!(
            blog_id: blog.id,
            category: row["Category"],
            primary_search_query: row["Primary Search Query"],
            title: row["Title"],
            title_length: row["Characters"],
            post_type: row["Post Type"].titleize.gsub(' ', '').underscore,
            status: row["Status"].titleize.gsub(' ', '').underscore,
            word_count: row["Word Count in Published Post"],
            date_published: row["Date Published"]
          )
        rescue ArgumentError
          import.custom_errors = "We had a couple of errors creating your hit list. We tried to pull in as much data as we could, but some could be missing. If you modified your Excel sheet, you may have modified it too much for this application to handle. If you haven't modifed it, you might want to check your excel sheet and check for any errors."
          import.save
        end
      end

      import.finished_processing = DateTime.now
      import.save
      puts "======== IMPORTED SPREADSHEET ========"
    end
  end
end
