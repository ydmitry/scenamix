Feature: User deletes a scene

  Background:
    Given I am logged in as an admin

  Scenario: Successful deletion
    Given a scene exists with:
      | title       | Dirty talk      |
      | description | Like Grumpy Cat |
    And I am on the scene page
    When I press "Delete"
    Then I should see "Scene 'Dirty talk' deleted."
    And I should not see "Drity talk"
