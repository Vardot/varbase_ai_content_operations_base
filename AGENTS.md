# AGENTS.md

Guidance for AI coding agents working on the Varbase AI Content Operations Base recipe.

This is a **private** recipe on GitHub (`Vardot/varbase_ai_content_operations_base`), not a drupal.org project.
Issues, pull requests and CI all live on GitHub.

## Before you start

- **`CHANGELOG.md`**: what changed in each release, newest first, and what it was checked on.
- **Pull requests and issues** on [github.com/Vardot/varbase_ai_content_operations_base](https://github.com/Vardot/varbase_ai_content_operations_base).
- **`README.md`**: what the recipe adds, how it stays safe, and the known issues.

## When you make a change

- One issue and one pull request per change. The PR says `Closes #<issue>` and ends with the Checkpoints list from
  `.github/pull_request_template.md`.
- Add an entry under `## [Unreleased]` in `CHANGELOG.md`.
- CI must be green before merging: `.github/workflows/ci.yml` applies the recipe twice on a real Varbase 11 site
  and runs the no-key recipe check, then the functional tests in `tests/features`.
- **The agent's tools are a safety boundary.** Never give it a tool that deletes, creates entities, or changes
  fields, bundles, users or configuration. The CI recipe check fails if it has one. Read and update only.
- **Keep the approval rule.** The prompt must keep "Save only after the editor clearly says yes" and "Never delete
  anything"; The CI recipe check checks both.
- Keep the assistant and the toolbar block to the editorial roles. Never open them to anonymous or authenticated.
- Keep the prompt free of any site's or client's names, field values or content. It names only Varbase field
  conventions, and the agent learns each content type's fields at run time.
- Test a prompt change with real questions as a Content admin (set `$extra = ['ask', <uid>, '<question>']` at the top of the inline check in `ci.yml` and run it with
  `ddev drush php:eval`), and
  check every save afterwards: one revision per item, the log message, status, author and text format unchanged.
- No PHP in the repository at all: no `.php`, `.module`, `.install` or `.inc` file. The no-key checks run inline in
  `.github/workflows/ci.yml` (`drush php:eval`), and the lint job fails on any PHP file.
- Never bump the version or tag a release without explicit maintainer approval. Tags are three-segment (`1.0.0`)
  and are never moved once pushed.
