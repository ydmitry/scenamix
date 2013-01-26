Given /^I am on the main page$/ do
  visit '/'
end

When /^I follow "(.*?)"$/ do |link|
  click_link link
end

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

When /^I go to the scenes page$/ do
  visit scenes_path
end

When /^I press "(.*?)"$/ do |button|
  click_button button
end

Then /^I should not see "(.*?)"$/ do |text|
  page.should have_no_content text
end

Given /^I am on the edit scene page$/ do
  visit edit_scene_path(@scene)
end

When /^I edit a scene$/ do
  fill_in 'Title', with: 'Date with Sarah'
  fill_in 'Description', with: 'Awesome date'

  click_button 'Update scene Info'
end

Given /^a scene has a response "(.*?)"$/ do |text|
  @response = @scene.responses.create(response: text)
end

Given /^I am on the edit response page$/ do
  visit edit_scene_response_path(@scene, @response)
end

When /^I edit a response$/ do
  fill_in 'Response', with: 'My favorite movie of all times'

  click_button 'Update response'
end
