Feature: Create scenes

Scenario: create a scene
  Given I am created a scene with content "test test test"
  Then I should be redirected to this scene page
  And I see "test test test"

Scenario: text formatting in scenes creation
  Given I am created a scene with content "first line\n\nsecond line"
  Then I should see "first line" in a separate paragraph
  And I should see "second line" in a separate paragraph

Scenario: text formatting in scenes creation (br)
  Given I am created a scene with content "first line\nsecond line"
  Then I should see "first line" and "second line" separated by break line
