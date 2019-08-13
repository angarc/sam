class BlogSpreadsheetImport < ApplicationRecord
  belongs_to :blog
  has_one_attached :spreadsheet, dependent: :destroy

  def self.process_spreadsheets
    BlogSpreadsheetImport.all.each do |import|
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
        puts "Created a Brand Plan Category"
      end

      puts 

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
        puts "Created a Potential Post"
      end

      puts

      hit_list = xlsx.sheet(3)
      hit_list = hit_list.parse(headers: true)
      hit_list[1..-1].each do |row|
        puts post = Post.create!(
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
      end

      import.destroy
    end
  end
end
