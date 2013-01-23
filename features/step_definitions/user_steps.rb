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

Given /^I am on the scene page with:$/ do |table|
  scene = Scene.create table.rows_hash
  visit scene_path(scene)
end

When /^I post a response "(.*?)"$/ do |text|
  fill_in 'Response', with: text

  click_button 'Post response to scene'
end
