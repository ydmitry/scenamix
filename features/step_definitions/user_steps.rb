# Add new scene
Given /^I am on the main page$/ do
  visit '/'
end

When /^I press "Add new scene" button$/ do
  click_link "Add new scene"
  save_and_open_page
end

Then /^I should see "Create New Scene" page$/ do
  #page.should have_content(text)
  has_text?("Create New Scene")
end

# Scenes create
Given /^I am on the scene creation page$/ do
  visit new_scene_path
end

When /^I create a scene with:$/ do |table|
  table.rows_hash.each do |key, value|
    fill_in key, with: value
  end

  click_button 'Create scene'
end

Then /^I should see "(.*?)"$/ do |text|
  page.should have_content(text)
end

# User posts response
Given /^a scene exists with:$/ do |table|
  @scene = Scene.create(table.rows_hash)
end

Given /^I am on the scene page$/ do
  visit scene_path(@scene)
end

When /^I post a response "(.*?)"$/ do |text|
  fill_in 'Response', with: text

  click_button 'Post response to scene'
end
