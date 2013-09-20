Feature: Create scenes

  Background:
    Given I am logged in as an user

    Scenario: Successful view of new scene page
      Given I am logged in as an user
      And I am on the main page
      When I follow "My scenes"
      When I follow "Add new scene"
      Then I should see "Create New Scene"

    Scenario: Successful scene creation
      Given I am on the scene creation page
      When I create a scene with:
        | Title       | You shall not pass |
        | Description | Breathtaking       |
      Then I should see "You shall not pass was successfully created."

    Scenario: Submit empty form
      Given I am on the scene creation page
      When I create a scene with:
        | Title       | |
        | Description | |
      Then I should see "Title can't be blank"
      And I should see "Description can't be blank"