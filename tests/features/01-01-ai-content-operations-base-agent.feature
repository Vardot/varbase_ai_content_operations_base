@varbase-ai-content-operations-base @ai @recipes @local @development @staging @production
Feature: Varbase AI Recipe - AI Content Operations Base - An assistant that reads and edits, and never deletes
  As a site owner
  I want the content operations assistant to work through Tool API tools that can list, load and update content
  So that editors can audit and fix content with AI while nothing can be deleted

  Background:
    Given I am a logged in user with the "Webmaster" user

  Scenario: Check the assistant uses the content operations agent
     When I go to "/admin/config/ai/ai-assistant"
     Then I should see "Content operations assistant"

  Scenario: Check the agent reads and updates content, and has no delete tool
     When I go to "/admin/config/ai/tools-automation/agents/varbase_ai_content_operations/edit/form"
     Then I should see "Content operations assistant"
      And I see visible list content tool, load content tool, update content tool
      And I don't see delete tool
