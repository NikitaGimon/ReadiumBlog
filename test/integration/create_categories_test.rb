require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest

    test "get new category form and create category" do
        get new_category_path
        # add gem 'rails-controller-testing' to Gemfile before using next method:
        assert_template 'categories/new'
        # count should be != 1 after execution of loop
        assert_difference 'Category.count', 1 do
            # post is like create (http post request)
            post categories_path, params: { category: {name: "sports"}}
            follow_redirect!
        end
        assert_template 'categories/index'
        # second parameter meaning: page, where first argument should be displayed
        assert_match 'sports', response.body
    end

end