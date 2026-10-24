[![Varbase](https://raw.githubusercontent.com/Vardot/varbase/11.0.x/images/varbase-logo.png)](https://www.drupal.org/project/varbase)

# Varbase AI Content Operations Base
[![Varbase AI Content Operations Base](https://img.shields.io/badge/Varbase%20AI%20Content%20Operations%20Base-1.0.0--alpha1-0d6efc?labelColor=001d38&style=flat-square)](https://www.drupal.org/project/varbase_ai_content_operations_base)

An **opt-in** Drupal recipe that gives the editors of a Varbase 11 site a **content operations assistant**
in the admin toolbar. Editors ask in their own words, and it audits, reports on and updates the site's content:

- "Which pages have broken internal links or missing alt text?"
- "Show me articles with no meta description and draft one for each based on the body."
- "Which content types or taxonomy terms have no published content, and which tags are near-duplicates?"
- "List everything published in the last 30 days by author and section, and flag anything still in draft for more
  than two weeks."
- "Find all articles mentioning [old name] and replace it with [new name], then show me the diffs before saving."

It works **with the editor's own permissions**, shows every change first, and **saves only what the editor
approves**, as a new revision with a log message. It never deletes, and it never touches users, permissions or the
content model.

It is not the visitor chatbot. [Varbase AI Chatbot Base](https://www.drupal.org/project/varbase_ai_chatbot_base) answers
visitors from published content and cannot change anything; this assistant is for signed-in editors only.

**Experimental.** [Tool API](https://www.drupal.org/project/tool) and [Tool Belt](https://www.drupal.org/project/tool_belt)
have no stable release (1.0.0-beta11 and 1.0.0-alpha6 when this was written). There is **no custom PHP and no
custom shell code** in the recipe. Its no-key checks run inline in CI, so the repository holds no PHP file at all.

## What it adds

| Part | What it does |
|---|---|
| Modules | Installs `ai_assistant_api`, `ai_chatbot`, `tool`, `tool_ai_connector` (Tool API tools as AI function calls), `tool_belt`, `tool_belt_content` and `tool_belt_entity`. |
| Agent `varbase_ai_content_operations` | "Content operations assistant". Seven tools: list content, read image alt text (pinned to image media), look up by a field value, list content types and vocabularies, load one item and read its full field values (for a text field's format), and update one item as a new revision. No tool that creates, deletes, or changes fields or configuration. |
| Assistant `varbase_ai_content_operations` | Runs the agent for Varbase's editorial roles only: Content editor, Content admin, SEO admin, Site admin (and administrators). Low temperature, conversation kept per user. |
| Block `gin_varbase_ai_content_operations` | The chat in the Gin admin toolbar, shown to those editorial roles. |
| Permissions | `access deepchat api` for the four editorial roles. |

### How it stays safe

- **The editor's own permissions.** Every tool checks access as the signed-in editor: listing skips what they cannot
  view, field by field, and a save is refused on anything they cannot edit.
- **Approval before any save.** It shows the item, the field and the value before and after, asks "Shall I save
  these N changes?", and saves only what the editor approves in the next message. A "yes" for changes it has not
  shown yet saves nothing: it shows them and asks.
- **Text formats kept.** Before saving a formatted field it reads the item's current format and sends it back
  unchanged; it never picks a format.
- **A revision for every save**, logged as "Content operations assistant: ..., approved by <editor>". Undo is the
  usual Revisions tab. Status, author, moderation state and dates are never changed.
- **Honest reports.** It says what it checked and what it could not, and reports only what the tools returned.
- **Content is data.** Instructions written inside content are ignored.

### Works on every Varbase site template

Field names differ between content types, so the agent reads one item of each type before a task and uses the
Varbase conventions: body text in `field_content` (or `body`), summary in `field_description`, meta description in
`field_seo_description`, featured image in `field_featured_image`, and the type's own category field as its section.
Those are the fields of Varbase Starter, Educare, Horizon Aid and The Rightup.

## Requirements

- Drupal core `^11.4`, Varbase 11, with Varbase's editorial roles (`content_editor`, `content_admin`, `seo_admin`,
  `site_admin`) and the Gin admin theme
- [`drupal/ai`](https://www.drupal.org/project/ai) `^1.5` and [`drupal/ai_agents`](https://www.drupal.org/project/ai_agents) `^1.3`
- [`drupal/tool`](https://www.drupal.org/project/tool) `^1.0@beta` and [`drupal/tool_belt`](https://www.drupal.org/project/tool_belt) `^1.0@alpha`
- A default chat model that supports tools (Configuration > AI > AI settings), as Varbase AI Base sets up. The
  answers in this README came from Claude Opus.

## Install and apply

```bash
# 1. Fetch the recipe.
ddev composer config --json extra.drupal-recipe-unpack.ignore '["drupal/varbase_ai_content_operations_base"]'
ddev composer require drupal/varbase_ai_content_operations_base:1.0.x-dev

# 2. Apply it.
ddev drush recipe ../recipes/varbase_ai_content_operations_base
ddev drush cr

# 3. Check it. Without arguments no AI key is needed. "ask <uid> <question>" asks the agent one real question as
#    that user.
```

Re-applying the recipe is safe. The ignore line keeps the recipe a locked package: without it core's
recipe-unpack plugin moves its requirements into the project's `composer.json` and drops the recipe itself.

Then sign in as an editor, open any admin page and open **Content operations** in the toolbar.

## Automated testing

GitLab CI on [git.drupalcode.org](https://git.drupalcode.org/project/varbase_ai_content_operations_base) (`.gitlab-ci.yml`) runs on every merge
request and every push to `1.0.x`, like the other Varbase AI recipes: `composer validate` and a lint of every YAML
file.

The functional tests in `tests/features` (Playwright and Cucumber through
[`@vardot/varbase-e2e`](https://www.npmjs.com/package/@vardot/varbase-e2e)) run against a site of your own:
`yarn install`, then `LAUNCH_URL=https://your-site.ddev.site yarn test`.

## Checked

On 11 October 2026, on a Varbase 11 development site with 21 content items written by three authors, the five
example questions were asked as a **Content admin**, through Claude Opus with the real tools:

| Question | Time | What it did |
|---|---|---|
| Broken links and alt text | 70 to 90 s | Found both broken internal links, the image with no alt and the one with an empty alt, and a featured image whose alt text is a file hash. |
| Missing meta descriptions | 37 s | Drafted five descriptions of 122 to 143 characters; after "yes", saved five revisions. |
| Content model hygiene | 78 s | Found the content type with nothing published, the unused tags, and the AI / Artificial Intelligence, SEO / Search Engine Optimization and Open-Source / Open Source pairs. |
| Editorial report | 51 s | Grouped ten items by author and section, totals adding up, and flagged the five items stalled for more than 14 days. |
| Rename a term | 37 s, then 42 s | Showed 10 occurrences in 9 fields of 5 items, a draft included; after "yes", saved them with the text format kept. |

Each save was checked afterwards: one new revision per item, by the editor, with the log message, and the status,
moderation state, author and text format unchanged.

The content model question was also asked through the toolbar chat in a browser, as a Content admin: the answer
came back in about 100 seconds as short lists, which is what the narrow chat panel shows well (it does not show
tables).

## Known issues

- **Saves can fail on sites with Varbase AI Taxonomy Tagging.** That recipe creates the `ai_automator_status` field
  with no allowed values, and AI Automators then stores "finished" in it, so every validated save outside the edit
  form fails with "ai_automator_status.0: The value you selected is not a valid choice". The assistant reports the
  failure and changes nothing. The fix is in Varbase AI Taxonomy Tagging; until then, an administrator can give the
  field storage its four values (pending, processing, failed, finished).
- **AI Agents' `list_content_entities` ends the whole chat request** when it is asked for a field an item does not
  have or the editor cannot view: it throws instead of returning a tool error, and the chat shows only "Sorry, I
  could not finish that". The recipe pins that tool to image media (`name` and `field_media_image`, for alt text)
  with `tool_usage_limits`; everything else goes through Tool Belt's `entity_list`, which skips missing fields.
- **Tool Belt's `entity_update` drops a text field's format** when it is given only the value, and `entity_list`
  returns text fields without their format. The agent therefore reads the format with `entity_load_by_id` and
  `entity_field_values` before it saves a formatted field.
- **Raise the AI request timeout.** A step of a tool-heavy answer can take more than the AI module's default 60
  seconds ("cURL error 28"). Set Configuration > AI > AI settings > request timeout to 180, or
  `drush config:set ai.settings request_timeout 180`.
- Content admins cannot list URL aliases or content types (those need "administer url aliases" and "administer
  content types"). The assistant reads each item's own `path` field instead, and says when it could not list the
  content types.
- Answers take 20 to 90 seconds and several model calls: it reads the content in pages of 50. On a large site, ask
  for one content type or section at a time.
- It suggests merging near-duplicate terms but does not merge them: that means retagging content and deleting a
  term, which it never does.

## Related recipes

| Recipe | What it does |
|---|---|
| [Varbase AI Content Review Base](https://www.drupal.org/project/varbase_ai_content_review_base) | Scores one content item against the site's style guide, from its Review tab. |
| [Varbase AI Chatbot Base](https://www.drupal.org/project/varbase_ai_chatbot_base) | A visitor chatbot that answers from published content only. |
| [Varbase AI Answers Base](https://www.drupal.org/project/varbase_ai_answers_base) | Ask AI: cited answers over the site's vector index. |

## License

GPL-2.0-or-later. See [LICENSE](LICENSE).
