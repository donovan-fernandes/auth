require "test_helper"

class PostsPageTest < ActionDispatch::IntegrationTest

  test "The feed at /posts still shows every post to a visitor who is not logged in." do
    post1 = Post.new
    post1["author"] = "Alice"
    post1["body"] = "Alice taco review"
    post1["image"] = "https://example.com/alice.jpg"
    post1.save

    post2 = Post.new
    post2["author"] = "Bob"
    post2["body"] = "Bob taco review"
    post2["image"] = "https://example.com/bob.jpg"
    post2.save

    get "/posts"

    assert_response :success
    assert_includes response.body, "Alice taco review"
    assert_includes response.body, "Bob taco review"
  end

  test "A visitor who is not logged in and opens the new post page is sent to the login page instead." do
    get "/posts/new"

    assert_redirected_to "/login"
  end

  test "A visitor who is not logged in and submits the form does not create a post, and is sent to the login page." do
    assert_no_difference "Post.count" do
      post "/posts", :params => {
        "author" => "Anonymous",
        "body" => "Unauthorized taco post",
        "image" => "https://example.com/anon.jpg"
      }
    end

    assert_redirected_to "/login"
  end

end
