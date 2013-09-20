Feature: User views scenes

  Background:
    Given I am logged in as an user

    Scenario: A scene is present
      Given I am on the scene creation page
      And I create a scene with:
        | Title       | You shall not pass |
        | Description | Breathtaking       |
      When I go to the scenes page
      Then I should see "MasterChef competition"
      And I should see "Absolutely delicious!"
