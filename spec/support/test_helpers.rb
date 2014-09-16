module Trackerapp::TestHelpers

  def login_user_with_request(user)
    page.driver.post("/sessions", { username: user.email, password: 'secret'})
  end

  def login_user_manually(user)
    visit "/login"
    fill_in 'username', with: @user.email
    fill_in 'password', with: "secret"
    click_button 'Log in'
  end

end
