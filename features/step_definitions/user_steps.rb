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

When /^I press "(.*?)" response$/ do |button|
    within(:css, ".response") do
      click_button button
    end
end

Then /^I should not see "(.*?)"$/ do |text|
  page.should have_no_content text
end

Given /^I am on the edit scene page$/ do
  visit edit_scene_path(@scene)
end

When /^I update a scene with:$/ do |table|
  table.rows_hash.each do |key, value|
    fill_in key, with: value
  end

  click_button 'Update scene Info'
end

Given /^a scene has a response "(.*?)"$/ do |text|
  @response = @scene.responses.create(response: text)
end

Given /^I am on the edit response page$/ do
  visit edit_scene_response_path(@scene, @response)
end

When /^I edit a response with "(.*?)"$/ do |text|
  fill_in 'Response', with: text

  click_button 'Update response'
end

Given /^I am on the sign up page$/ do
  visit '/users/sign_up'
end

When /^I sign up$/ do
  fill_in 'Email', with: 'andrii.ponomarov@gmail.com'
  fill_in 'user_password', with: '111111'

  click_button 'Sign up'
end

Given /^I am logged in as an admin$/ do
  User.create! do |user|
    user.email = 'andrii.ponomarov@gmail.com'
    user.password = '111111'
    user.password_confirmation = '111111'
    user.admin = true
  end

  visit sign_in_path

  fill_in 'Email', with: 'andrii.ponomarov@gmail.com'
  fill_in 'Password', with: '111111'
  click_button 'Sign in'
end
