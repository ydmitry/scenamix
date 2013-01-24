Feature: Add new scene

  Scenario: Successful view of new scene page
    Given I am on the main page
    When I press "Add new scene" button
    Then I should see "Create New Scene" page
