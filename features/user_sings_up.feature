Feature: User signs up

  Scenario: Successful sign up
    Given I am on the sign up page
    When I sign up
    Then I should see "Welcome! You have signed up successfully."
