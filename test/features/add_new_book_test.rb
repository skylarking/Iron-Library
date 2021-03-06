require "test_helper"

class AddNewBookTest < Capybara::Rails::TestCase
  setup do
    User.create! first_name: "First", last_name: "Last", email: "test@test.com", password: "test12345"
    Author.create! id: "1", first_name: "First", last_name: "Last", bio: "Bio text"
  end

  test "Add book" do
    visit root_path
    click_link "Login"
    fill_in "Email", with: "test@test.com"
    fill_in "Password", with: "test12345"
    click_button "Login"

    visit new_book_path
      within ("#new_book") do
        fill_in "Title", with: "Test Book"
        fill_in "Photo url", with: "www.google.com"
        fill_in "Price", with: "10.00"
        fill_in "Author", with: "1"
        click_button "Create Book"
      end
    visit root_path
    assert_content page, "Test Book"
  end
end
