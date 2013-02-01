Feature: User signs up

  Scenario: Successful sign up
    Given I am on the sign up page
    When I sign up
    Then I should see "Welcome! You have signed up successfully."

  Scenario: Submit empty form
    Given I am on the sign up page
    When I press "Sign up"
    Then I should see "Email can't be blank"
    And I should see "Password can't be blank"
