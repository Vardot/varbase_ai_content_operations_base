@varbase-ai @content-operations @recipe
Feature: The Varbase AI Content Operations Base recipe gives editors a content operations assistant
  As a Varbase site builder
  I want the recipe to add the agent, the assistant and the toolbar chat for editors
  So that editors can audit, report on and update content by asking in their own words

  Scenario: The content operations agent exists
    Given I am a logged in user with the "Webmaster" user
    When I navigate to "/admin/config/ai/tools-automation/agents"
    Then I should see "Content operations assistant"
     And I the page should not have PHP errors

  Scenario: The assistant exists
    Given I am a logged in user with the "Webmaster" user
    When I navigate to "/admin/config/ai/ai-assistant"
    Then I should see "Content operations assistant"
     And I the page should not have PHP errors

  Scenario: A content editor's admin pages load with the assistant in the toolbar
    Given I am a logged in user with the "Content editor" user
    When I navigate to "/admin/content"
    Then I the page should not have PHP errors

  Scenario: A signed-in user without an editorial role cannot see the assistant settings
    Given I am a logged in user with the "Authenticated user" user
    When I navigate to "/admin/config/ai/ai-assistant"
    Then I should not see "Content operations assistant"
     And I the page should not have PHP errors

  Scenario: An anonymous visitor cannot see the assistant settings
    Given I am an anonymous user
    When I navigate to "/admin/config/ai/ai-assistant"
    Then I should not see "Content operations assistant"
     And I the page should not have PHP errors
