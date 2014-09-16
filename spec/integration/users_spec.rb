require 'spec_helper'

describe "User" do
  before(:each) do
    @account = FactoryGirl.create(:account)
    @user = FactoryGirl.create(:user, account: @account)
    @admin = FactoryGirl.create(:admin, account: @account)
    @project = FactoryGirl.create(:project, users: [@user, @admin], account: @account)

    login_user_with_request(@admin)
    visit "/admin"
  end

  describe "GET /users" do
    it "lists existing users" do
      page.should have_content("tester")
      page.should have_content("tester_admin")
    end

    it "lists entries per user" do
      entry = FactoryGirl.create(:entry, project: @project, user: @user)
      previous_entry = FactoryGirl.create(:entry, date: 1.month.ago, project: @project, user: @user)
      entry_next = FactoryGirl.create(:entry, date: 1.month.from_now, project: @project, user: @user)
      first(:link, "View").click
      page.should have_content(entry.description)

      click_link("Last month")
      page.should have_content(previous_entry.description)
    end

    it "shows no entries for user who has none" do
      entry = FactoryGirl.create(:entry, project: @project, user_id: @admin.id)
      entry_previous = FactoryGirl.create(:entry, date: 1.month.ago, project: @project, user: @admin)
      entry_next = FactoryGirl.create(:entry, date: 1.month.from_now, project: @project, user: @admin)
      first(:link, "View").click
      page.should have_content("0 hours and 0 minutes")
    end
  end

  describe "EDIT /users" do
    it "shows edit form on Edit click" do
      first(:link, "Edit").click
      page.should have_content("Edit")
      page.should have_content("Username")
      page.should have_content("Email")
      page.should have_content("Password")
      page.should have_content("Password confirm")
      page.should have_content("Admin?")
    end
  end

  describe "CREATE /users" do
    it "creates user" do
      first(:link, "Add user").click
      fill_in 'user_username', with: "supertester"
      fill_in 'user_email', with: "supertester@tester.cz"
      fill_in 'user_password', with: "pida_is_da_best"
      fill_in 'user_password_confirmation', with: "pida_is_da_best"
      fill_in 'user_language', with: "en"
      click_button 'Save'

      page.should have_content("supertester")
    end
  end
end

