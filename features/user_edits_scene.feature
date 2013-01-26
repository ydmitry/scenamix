Feature: User edits a scene

  Scenario: Successful scene editing
    Given a scene exists with:
      | title       | Date with Maggy |
      | description | Best date ever  |
    And I am on the edit scene page
    When I edit a scene
    Then I should see "Date with Sarah was successfully updated."