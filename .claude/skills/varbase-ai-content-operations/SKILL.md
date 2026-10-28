---
name: varbase-ai-content-operations
description: "Apply, repair and verify Varbase AI Content Operations on a Varbase 11 site: the editors' content operations assistant in the Gin toolbar (audits, drafts, renames; saves only what the editor approves). Install and apply commands, inputs, config, post-apply steps, browser checks, traps and versions, read from the recipe code. Use when adding, fixing or checking Varbase AI Content Operations."
---

# Varbase AI Content Operations

Read from `recipe.yml`, `composer.json`, README, CHANGELOG and `git log` at the latest tag, 28 October 2026. Re-check versions on drupal.org before relying on them. For the full Varbase AI apply order, see the Varbase AI recipes docs page.

## Recipes

| Recipe | Latest | Stability | Require |
|---|---|---|---|
| `varbase_ai_content_operations_base` | 1.0.0-beta1 | beta | `drupal/varbase_ai_content_operations_base:~1` |

Docs (the code wins where they differ):
- https://docs.varbase.vardot.com/developers/understanding-varbase/varbase-ai-recipes/varbase-ai-content-operations-base

## What it does

- Installs `node`, `user`, `block`, `ai`, `ai_agents`, `ai_assistant_api`, `ai_chatbot`, `tool`, `tool_ai_connector`, `tool_belt`, `tool_belt_content`, `tool_belt_entity`, `gin`. Creates agent and assistant `varbase_ai_content_operations` and block `gin_varbase_ai_content_operations`; grants roles `content_editor`, `content_admin`, `seo_admin`, `site_admin`.
- Reads and saves through the Tool API with the editor's own permissions, shows every change first, saves approved changes as new revisions, never deletes.
- Composer: `ai ^1.5`, `ai_agents ^1.3`, `gin ^5.0`, `tool ^1.0@beta`, `tool_belt ^1.0@alpha`. No inputs. Needs a default chat model that supports tools.

## Apply

All commands in DDEV, from the project root; recipes are applied from the docroot path `../recipes/<name>`. Take a snapshot first: `ddev snapshot --name before-varbase-ai-content-operations`. Add each recipe to `extra.drupal-recipe-unpack.ignore` in `composer.json` before requiring it (read the list first: `composer config --json` replaces it).

```bash
ddev composer require drupal/varbase_ai_content_operations_base:~1
ddev drush cr
ddev drush recipe ../recipes/varbase_ai_content_operations_base -y
ddev drush cr
```

## After the apply

- If taxonomy tagging is applied, give the field storage `ai_automator_status` its allowed values (pending, processing, failed, finished), after asking: without them every save fails validation.

## Verify

- As an editor (not user 1), open the assistant in the Gin toolbar; ask "which pages have images with no alt text" and "which internal links are broken"; approve one suggested change and see a new revision.

Test as a real editor or visitor, not user 1: a superuser bypasses permissions.

## Traps

- Saves fail with "ai_automator_status.0: not a valid choice": the tagging recipe creates that field with no allowed values.
- Broad date questions ("how many posts last month") are miscounted: its list tool has no date filter. Demo it with audit questions.
- Needs the Varbase roles; unverified on plain Drupal CMS.

## History

Started 22 Oct 2026, 1.0.0-alpha1 24 Oct, 1.0.0-beta1 27 Oct (functional tests #3633136).
