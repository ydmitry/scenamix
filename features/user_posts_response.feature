Feature: User posts a response

  Scenario: Successful response post
    Given I am on the scene page with:
      | title       | Job interview |
      | description | At a startup. |
    When I post a response "Tell me about yourself."
    Then I should see "Response to Job interview was successfully posted."
