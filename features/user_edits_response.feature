Feature: User edits a response

  Scenario: Successful edit
    Given a scene exists with:
      | title       | Wake up, Neo... |
      | description | Classic         |
    And a scene has a response "One of my favorite movies"
    And I am on the edit response page
    When I edit a response
    Then I should see "#Response was successfully updated."
    And I should see "My favorite movie of all times"
    But I should not see "One of my favorite movies"
