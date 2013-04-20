Feature: User views scenes

  Scenario: A scene is present
    Given a scene exists with:
      | title       | MasterChef competition |
      | description | Absolutely delicious!  |
    When I go to the scenes page
    Then I should see "MasterChef competition"
    And I should see "Absolutely delicious!"

  Scenario: A scene is hidden
    Given a scene exists with:
      | title       | Hobbit				|
      | description | There and back		|
      | hidden      | true					|
    When I go to the scenes page
    Then I should not see "Hobbit"
