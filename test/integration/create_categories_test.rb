require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest

    def setup
        @user = User.create(username: "john", email: "john@example.com", password: "password", admin: true)
    end

    test "get new category form and create category" do
        sign_in_as(@user, "password")
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


    test "invalid category submission results in failure" do
        sign_in_as(@user, "password")
        get new_category_path
        # add gem 'rails-controller-testing' to Gemfile before using next method:
        assert_template 'categories/new'
        # count should be = 1 after execution of loop
        assert_no_difference 'Category.count' do
            # post is like create (http post request)
            post categories_path, params: { category: {name: " "}}
        end
        assert_template 'categories/new'
        # it means that in DOM <h2 class="panel-title"> and <div class="panel-body"> appears
        assert_select 'h2.panel-title'
        assert_select 'div.panel-body'
    end
end