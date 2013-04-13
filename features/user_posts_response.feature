Feature: User posts a response

  Scenario: Successful response post
    Given a scene exists with:
      | title       | Job interview |
      | description | At a startup. |
    And I am on the scene page
    And I follow "Write sequel to scenario"
    When I post a response "Tell me about yourself."
    Then I should see "Response to Job interview was successfully posted."

  Scenario: User post empty response
    Given a scene exists with:
      | title       | Job interview |
      | description | At a startup. |
    And I am on the scene page
    And I follow "Write sequel to scenario"
    When I post a response ""
    Then I should see "Response can't be blank"