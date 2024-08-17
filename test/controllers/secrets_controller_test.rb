require "test_helper"

class SecretsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @secret = secrets(:one)
  end

  test "should get index" do
    get secrets_url, headers: { "Authorization" => "Bearer #{JWT.encode({ email: users(:one).email, sub: users(:one).id }, nil, 'none')}" }
    assert_response :success
  end

  test "should get new" do
    get new_secret_url, headers: { "Authorization" => "Bearer #{JWT.encode({ email: users(:one).email, sub: users(:one).id }, nil, 'none')}" }
    assert_response :success
  end

  test "should create secret" do
    assert_difference("Secret.count") do
      post secrets_url, params: { secret: { name: @secret.name } }, headers: { "Authorization" => "Bearer #{JWT.encode({ email: users(:one).email, sub: users(:one).id }, nil, 'none')}" }
    end

    assert_redirected_to secret_url(Secret.last)
  end

  test "should show secret" do
    get secret_url(@secret), headers: { "Authorization" => "Bearer #{JWT.encode({ email: users(:one).email, sub: users(:one).id }, nil, 'none')}" }
    assert_response :success
  end

  test "should get edit" do
    get edit_secret_url(@secret), headers: { "Authorization" => "Bearer #{JWT.encode({ email: users(:one).email, sub: users(:one).id }, nil, 'none')}" }
    assert_response :success
  end

  test "should update secret" do
    patch secret_url(@secret), params: { secret: { name: @secret.name } }, headers: { "Authorization" => "Bearer #{JWT.encode({ email: users(:one).email, sub: users(:one).id }, nil, 'none')}" }
    assert_redirected_to secret_url(@secret)
  end

  test "should destroy secret" do
    assert_difference("Secret.count", -1) do
      delete secret_url(@secret), headers: { "Authorization" => "Bearer #{JWT.encode({ email: users(:one).email, sub: users(:one).id }, nil, 'none')}" }
    end

    assert_redirected_to secrets_url
  end
end
