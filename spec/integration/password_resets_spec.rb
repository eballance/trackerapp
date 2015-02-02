require 'spec_helper'

describe "PasswordResets" do
  it 'can reset password' do
    @user = FactoryGirl.create(:user)
    visit '/'
    fill_in 'email', with: @user.email
    click_button 'Reset password'
    page.should have_content('Instructions have been sent to your email.')

    mail = ActionMailer::Base.deliveries.last
    expect(mail['to'].to_s).to eql(@user.email)

    @user.reload

    visit "/password_resets/#{@user.reset_password_token}/edit"
    fill_in 'user[password]', with: 'new_password'
    fill_in 'user[password_confirmation]', with: 'new_password'
    click_button 'Change password'
    page.should have_content('Password was successfully updated.')

    @user.reload

    auth = User.authenticate(@user.email, 'new_password')

    expect(@user).to be(@user)
  end
end
