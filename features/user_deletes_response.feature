Feature: User deletes a response

  Background:
    Given I am logged in as an admin

	Scenario: Successful deletion
		Given a scene exists with:
			| title 			| Mortal Combat |
			| description | Finish him    |
		And I am on the scene page
		When I post a response "Raiden is the best"
		And I press "Delete" response
		Then I should not see "Raiden is the best"
