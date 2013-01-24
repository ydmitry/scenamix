Feature: User views scenes

  Scenario: A scene is present
    Given a scene exists with:
      | title       | MasterChef competition |
      | description | Absolutely delicious!  |
    When I go to the scenes page
    Then I should see "MasterChef competition"
    And I should see "Absolutely delicious!"
