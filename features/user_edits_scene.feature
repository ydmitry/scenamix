Feature: User edits a scene

  Scenario: Successful scene editing
    Given a scene exists with:
      | title       | Date with Maggy |
      | description | Best date ever  |
    And I am on the edit scene page
    When I update a scene with:
      | Title       | Date with Sarah |
      | Description | Awesome date    |
    Then I should see "Date with Sarah was successfully updated."

  Scenario: with empty fields
    Given a scene exists with:
      | title       | Date with Maggy |
      | description | Best date ever  |
    And I am on the edit scene page
    When I update a scene with:
      | Title       | |
      | Description | |
    Then I should see "Title can't be blank"
    And I should see "Description can't be blank"
