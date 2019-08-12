class CreateStatisticOverviews < ActiveRecord::Migration[6.0]
  def up
    create_table :statistic_overviews do |t|
      t.references :blog, index: true

      # Snapshot
      # t.integer :total_number_of_posts_published
      # t.integer :pillar_posts_completed
      # t.integer :staple_posts_completed
      # t.integer :response_posts_completed
      # t.integer :posts_that_are_one_month_old_or_less
      # t.integer :posts_that_are_two_months_old
      # t.integer :posts_that_are_three_months_old
      # t.integer :posts_that_are_four_months_old
      # t.integer :posts_that_are_five_months_old
      # t.integer :posts_that_are_six_months_old
      # t.integer :posts_that_are_seven_months_old
      # t.integer :posts_that_are_eight_months_old_or_older

      # Commitment Required
      # t.integer :total_words_left_to_finish_hit_list
      # t.integer :approx_writing_hours_to_finish_hit_list
      # t.integer :approx_writing_hours_to_finish_pillar_posts
      # t.integer :approx_writing_hours_to_finish_staple_posts
      # t.integer :approx_writing_Hours_to_finish_response_posts
      # t.integer :total_number_words_left_to_finish_hit_list
      # t.integer :cost_to_buy_rest_of_hit_list_at_three_cents_per_word
      # t.integer :cost_to_buy_ten_posts_of_each_post_type

      # Hit list Statistics
      # t.integer :total_number_of_posts_in_hit_list
      # t.integer :pillar_posts_in_hit_list
      # t.integer :staple_posts_in_hit_list
      # t.integer :response_posts_in_hit_list

      # Completion Rate
      # t.integer :percent_of_sixty_steps_content_completed
      # t.integer :pillar_posts_remaining_on_hit_list
      # t.integer :staple_posts_remaining_on_hit_list
      # t.integer :response_posts_remaining_on_hit_list

      # Content Age
      # t.integer :total_completed_posts
      # t.integer :posts_published_over_thirty_five_weeks_ago
      # t.integer :pillar_posts_published_over_thirty_five_weeks_ago
      # t.integer :staple_posts_published_over_thirty_five_weeks_ago
      # t.integer :response_posts_published_over_thirty_five_weeks_ago
      # t.integer :posts_published_in_the_last_seven_days
      # t.integer :posts_published_in_the_last_thirty_days
      # t.integer :posts_published_in_the_last_sixty_days
      # t.integer :posts_published_in_the_last_ninety_days
      # t.integer :posts_published_in_the_last_one_twenty_days
      # t.integer :posts_published_in_the_last_one_fifty_days
      # t.integer :posts_published_in_the_last_one_eighty_days
      # t.integer :posts_published_in_the_last_two_ten_days
      # t.integer :posts_published_in_the_last_two_forty_days

      t.string :slug, unique: :true
      t.integer :status, default: 0
      t.integer :position
      t.timestamps
    end

    # ControlRoom::Section.create(icon: 'cubes', title: "Statistic Overviews", controller: "statistic_overviews")
  end

  def down
    # ControlRoom::Section.find_by_title("Statistic Overviews").destroy
    drop_table :statistic_overviews
  end
end