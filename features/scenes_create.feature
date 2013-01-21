Feature: Create scenes

  Scenario: Successful scene creation
    Given I am on the scene creation page
    When I create a scene with:
      | Title       | You shall not pass |
      | Description | Breathtaking       |
    Then I should see "You shall not pass was successfully created."

Scenario: text formatting in scenes creation
  Given I am created a scene with content "first line\n\nsecond line"
  Then I should see "first line" in a separate paragraph
  And I should see "second line" in a separate paragraph

Scenario: text formatting in scenes creation (br)
  Given I am created a scene with content "first line\nsecond line"
  Then I should see "first line" and "second line" separated by break line
