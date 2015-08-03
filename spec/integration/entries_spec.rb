require 'spec_helper'

describe "Entries" do
  describe "Not Admin" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @project = FactoryGirl.create(:project, users: [@user])
    end

    it "lists existing entries" do
      login_user_with_request(@user)

      this_month_entry = FactoryGirl.create(:entry, project: @project, user: @user)
      previous_month_entry = FactoryGirl.create(:entry, date: 1.month.ago, project: @project, user: @user)

      visit "/"
      page.should have_content(this_month_entry.description)
      first(:link, "Last month").click
      page.should have_content(previous_month_entry.description)
    end

    it "lists existing entries by implicit range" do
      login_user_with_request(@user)

      this_month_entry = FactoryGirl.create(:entry, project: @project, user: @user)
      previous_month_entry = FactoryGirl.create(:entry, date: 1.month.ago, project: @project, user: @user)

      visit "/?kind=range"
      page.should have_content(this_month_entry.description)
      first(:link, "Last month").click
      page.should have_content(previous_month_entry.description)
    end

    it "lists existing entries by explicit range" do
      login_user_with_request(@user)

      this_month_entry = FactoryGirl.create(:entry, project: @project, user: @user)
      previous_month_entry = FactoryGirl.create(:entry, date: 1.month.ago, project: @project, user: @user)

      visit "/?kind=range&from=#{1.month.ago.to_date.to_s}&to=#{Date.today.to_s}"
      page.should have_content(this_month_entry.description)
      first(:link, "Last month").click
      page.should have_content(previous_month_entry.description)
    end

    it "creates entry", js: true do
      login_user_manually(@user)

      page.should have_content("0 hours and 0 minutes")

      fill_in 'entry_form_time_spent', with: "1.5 h"
      select @project.name, from: 'entry_form_project_id'
      fill_in 'entry_form_description', with: "test description 5"
      click_button 'Add'
      page.should have_content("test description 5")

      fill_in 'entry_form_time_spent', with: "130"
      select @project.name, from: 'entry_form_project_id'
      fill_in 'entry_form_description', with: "test description 6"
      page.execute_script("$('#entry_form_date').val('#{1.month.ago}');")
      click_button 'Add'
      click_link("Last month")

      page.should have_content("test description 6")
    end

    it "creates entry and remembers project" do
      second_project = FactoryGirl.create(:project, users: [@user])
      FactoryGirl.create(:entry, date: 1.month.from_now, project: second_project, user: @user)
      login_user_manually(@user)
      page.should have_select('entry_form_project_id', selected: second_project.name)
    end
  end

  describe "Admin" do
    before(:each) do
      @user = FactoryGirl.build(:admin)
      @project = FactoryGirl.create(:project, users: [@user])
    end

    it "lists existing entries" do
      login_user_with_request(@user)

      entry = FactoryGirl.create(:entry, project: @project, user: @user)
      entry_previous = FactoryGirl.create(:entry, date: 1.month.ago, project: @project, user: @user)

      visit "/"
      page.should have_content(entry.description)

      first(:link, "Last month").click
      page.should have_content(entry_previous.description)
    end

    it "creates entry", js: true do
      login_user_manually(@user)

      page.should have_content("0 hours and 0 minutes")

      fill_in 'entry_form_time_spent', with: "1.5 h"
      select @project.name, from: 'entry_form_project_id'
      fill_in 'entry_form_description', with: "test description 5"
      click_button 'Add'
      page.should have_content("test description 5")

      fill_in 'entry_form_time_spent', with: "130"
      select @project.name, from: 'entry_form_project_id'
      fill_in 'entry_form_description', with: "test description 6"
      page.execute_script("$('#entry_form_date').val('#{1.month.ago}');")
      click_button 'Add'
      click_link("Last month")
      page.should have_content("test description 6")
    end
  end
end

