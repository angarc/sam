require 'test_helper'
require 'generators/element/element_generator'

class ElementGeneratorTest < Rails::Generators::TestCase
  tests ElementGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
