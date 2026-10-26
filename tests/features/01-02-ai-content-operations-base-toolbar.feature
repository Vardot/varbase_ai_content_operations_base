@varbase-ai-content-operations-base @ai @recipes @local @development
Feature: Varbase AI Recipe - AI Content Operations Base - The assistant in the editor's toolbar
  As a content editor
  I want to open the content operations assistant from any admin page
  So that I can ask it to audit, report on or fix content in my own words

  Scenario Outline: Check the "<user>" user opens the assistant from the toolbar
    Given I am a logged in user with the "<user>" user
     When I go to "/admin/content"
      And I click the "Open AI assistant" button
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
     Then I don't see assistant button
      And I should see "authenticated_user"

  @ai-provider
  Scenario: Verify the assistant reports the blog posts still in draft
    Given I am a logged in user with the "Content editor" user
     When I go to "/admin/content"
      And I click the "Open AI assistant" button
      And I click chat input
      And I fill in the field "#text-input" with "Which blog posts are still in draft?"
      And I press the key "Enter"
      And I wait for the text "Working on it" to disappear
     Then I should not see "Sorry, I could not finish that."
