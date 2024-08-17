require "application_system_test_case"

class SecretsTest < ApplicationSystemTestCase
  setup do
    @secret = secrets(:one)
  end

  test "visiting the index" do
    visit secrets_url
    assert_selector "h1", text: "Secrets"
  end

  test "should create secret" do
    visit secrets_url
    click_on "New secret"

    fill_in "Name", with: @secret.name
    fill_in "User", with: @secret.user_id
    click_on "Create Secret"

    assert_text "Secret was successfully created"
    click_on "Back"
  end

  test "should update Secret" do
    visit secret_url(@secret)
    click_on "Edit this secret", match: :first

    fill_in "Name", with: @secret.name
    fill_in "User", with: @secret.user_id
    click_on "Update Secret"

    assert_text "Secret was successfully updated"
    click_on "Back"
  end

  test "should destroy Secret" do
    visit secret_url(@secret)
    click_on "Destroy this secret", match: :first

    assert_text "Secret was successfully destroyed"
  end
end
