@varbase-ai-content-operations-base @ai @recipes @a11y @local @development @staging @production
Feature: Varbase AI Recipe - AI Content Operations Base - Accessible assistant
  As a content editor who uses assistive technology
  I want the content page with the assistant to work with a keyboard and a screen reader
  So that I can ask the assistant like anyone else

  Scenario: Check the content page gives every field a label and every link a name
    Given I am a logged in user with the "Content editor" user
     When I go to "/admin/content"
     Then every form field should have an accessible label
      And every link should have an accessible name
      And every ARIA role should be valid
