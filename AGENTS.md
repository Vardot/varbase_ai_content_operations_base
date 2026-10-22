# AGENTS.md

Guidance for AI coding agents working on the Varbase AI Content Operations Base recipe.

This is a drupal.org project: [drupal.org/project/varbase_ai_content_operations_base](https://www.drupal.org/project/varbase_ai_content_operations_base).
Issues live in its [issue queue](https://www.drupal.org/project/issues/varbase_ai_content_operations_base) and merge requests on
[git.drupalcode.org](https://git.drupalcode.org/project/varbase_ai_content_operations_base). Its default branch is `1.0.x`; the
GitHub repository is a mirror and takes no issues or pull requests.

## Before you start

- **`CHANGELOG.md`**: what changed in each release, newest first, and what it was checked on.
- **Issues and merge requests** on [drupal.org](https://www.drupal.org/project/issues/varbase_ai_content_operations_base).
- **`README.md`**: what the recipe adds, how it stays safe, and the known issues.

## When you make a change

- One drupal.org issue and one issue-fork merge request per change, titled `<type>: #<issue> Summary`. The MR
  description ends with the Checkpoints list from `.gitlab/merge_request_templates/default.md`.
- CI must be green before merging: `.gitlab-ci.yml` on git.drupalcode.org validates `composer.json` and lints
  every YAML file.
- No PHP in the repository at all: no `.php`, `.module`, `.install` or `.inc` file.
- Add an entry under `## [Unreleased]` in `CHANGELOG.md`.
- **The agent's tools are a safety boundary.** Never give it a tool that deletes, creates entities, or changes
  fields, bundles, users or configuration. The CI recipe check fails if it has one. Read and update only.
- **Keep the approval rule.** The prompt must keep "Save only after the editor clearly says yes" and "Never delete
  anything"; The CI recipe check checks both.
- Keep the assistant and the toolbar block to the editorial roles. Never open them to anonymous or authenticated.
- Keep the prompt free of any site's or client's names, field values or content. It names only Varbase field
  conventions, and the agent learns each content type's fields at run time.
- Never bump the version or tag a release without explicit maintainer approval. Tags are three-segment (`1.0.0`)
  and are never moved once pushed.
