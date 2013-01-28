Feature: User deletes a response

	Scenario: Successful deletion
		Given a scene exists with:
			| title 			| Mortal Combat |
			| description | Finish him    |
		And I am on the scene page
		When I post a response "Raiden is the best"
		And I press "Delete" response
		Then I should not see "Raiden is the best"