require 'test_helper'

class CreateArticleTest < ActionDispatch::IntegrationTest

    def setup
        @user = User.create(username: "john", email: "john@example.com", password: "password")
    end
    
    test "get new article form and create article" do
        sign_in_as(@user, "password")
        get new_article_path
        # add gem 'rails-controller-testing' to Gemfile before using next method:
        assert_template 'articles/new'
        # count should be != 1 after execution of loop
        assert_difference 'Article.count', 1 do
            # post is like create (http post request)
            post articles_path, params: { article: {title: "sports", description: "dkkdkdksdkskdskdkdskds"}}
            follow_redirect!
        end
        assert_template 'articles/show'
        # second parameter meaning: page, where first argument should be displayed
        assert_match 'sports', response.body
    end


    test "invalid article submission results in failure" do
        sign_in_as(@user, "password")
        get new_article_path
        # add gem 'rails-controller-testing' to Gemfile before using next method:
        assert_template 'articles/new'
        # count should be = 1 after execution of loop
        assert_no_difference 'Category.count' do
            # post is like create (http post request)
            post articles_path, params: { article: {title: " ", description: " "}}
        end
        assert_template 'articles/new'
        # it means that in DOM <h2 class="panel-title"> and <div class="panel-body"> appears
        assert_select 'h2.panel-title'
        assert_select 'div.panel-body'
    end

end