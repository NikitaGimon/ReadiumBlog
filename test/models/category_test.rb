require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
    def setup
        @category = Category.new(name: "sports")
    end

    test "category should be valid" do
        assert @category.valid?
        #check that Category model and migration are present
    end

    test "name should be present" do
        @category.name = " "
        assert_not @category.valid?
        # assert_not check if the first statement is invalid, if invalid- test will be passed
    end

    test "name should be unique" do
        @category.save
        category2 = Category.new(name: "sports")
        assert_not category2.valid? 
    end

    test "name should not be too long" do
        @category.name = "z" * 28 
        assert_not @category.valid?
    end

    test "name should not be too short" do
        @category.name = "z" * 2 
        assert_not @category.valid?
    end
end