Feature: Create scenes

  Scenario: Successful scene creation
    Given I am on the scene creation page
    When I create a scene with:
      | Title       | You shall not pass |
      | Description | Breathtaking       |
    Then I should see "You shall not pass was successfully created."
