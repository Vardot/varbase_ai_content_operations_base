@varbase-ai-content-operations-base @ai @recipes @local @development
Feature: Varbase AI Recipe - AI Content Operations Base - The assistant in the editor's toolbar
  As a content editor
  I want to open the content operations assistant from any admin page
  So that I can ask it to audit, report on or fix content in my own words

  Scenario Outline: Check the "<user>" user opens the assistant from the toolbar
    Given I am a logged in user with the "<user>" user
     When I go to "/admin/content"
      And I click the "Open AI assistant" button
      And I click allow the chat assistant this time
     Then I should see "I help you keep the content correct, findable and consistent."
      And I see visible chat input

    Examples:
      | user           |
      | Content editor |
      | Content admin  |
      | SEO admin      |

  Scenario: Check a signed-in user without an editorial role has no assistant
    Given I am a logged in user with the "Authenticated user" user
     When I go to "/user"
     Then I should see "authenticated_user"
      And I don't see assistant button

  Scenario: Verify the assistant answers an editor's question about the site's content
    CI has no real RAG or vector database hosting: it uses only what the pipeline has and the free amazee.ai
    trial from Drupal CMS AI (thanks to amazee.ai). A short answer comes back within 10 seconds.
    Given I am a logged in user with the "Content editor" user
     When I go to "/admin/content"
      And I click the "Open AI assistant" button
      And I click allow the chat assistant this time
      And I fill in "Ask me anything" with "Which blog posts are still in draft?"
      And I press the key "Enter"
      And I wait max of 10 seconds
      And I wait for the text "Working on it" to disappear
     Then I should see "Which blog posts are still in draft?"
      And I should not see "Sorry, I could not finish that."
