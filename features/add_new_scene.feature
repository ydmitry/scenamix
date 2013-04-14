Feature: Add new scene

  Scenario: Successful view of new scene page
    Given I am on the main page
    When I follow "Scenes"
    When I follow "Add new scene"
    Then I should see "Create New Scene"
