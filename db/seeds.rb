# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Scene.create(title: 'Job interview', description: 'An example of a job interview. What you should say that to successfully pass the interview')
Scene.create(title: 'Hiring to a job', description: 'Example of employment. What you need ask, to check the candidate for the proposed position')
Scene.create(title: 'Best first date for girls', description: "Girls, what's the Best first date you have ever imagined?")
Scene.create(title: 'Best first date for men', description: "Guys, what's the Best first date you have ever imagined?'")
Scene.create(title: 'Space invasion', description: 'What do you think about how to best conquer space?')

Role.create(name: 'Actor', description: 'Action to solve a problem')
Role.create(name: 'Critic', description: 'Negative consequense of an action')
Role.create(name: 'Optimist', description: 'Positive consequense of an action')

user = User.create! :email => 'admin@test.com', :password => '123456', :password_confirmation => '123456', :admin => true
