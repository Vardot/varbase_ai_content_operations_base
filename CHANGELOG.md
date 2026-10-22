# Changelog

All notable changes to the Varbase AI Content Operations Base recipe are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.1] - 2026-10-12
### Changed
- Removed `tests/verify.php`: the repository now holds no PHP file. CI runs the same no-key checks inline
  (`drush php:eval` in `.github/workflows/ci.yml`), and the lint job fails on any `.php`, `.module`, `.install` or
  `.inc` file (#3).

### Checked
- CI on 1.0.x (https://github.com/Vardot/varbase_ai_content_operations_base/actions/runs/38238501443): the lint job found no PHP file, the recipe applied twice, the inline
  check printed `RESULT: PASS` and the functional tests passed.

## [1.0.0] - 2026-10-11
### Added
- The recipe: a content operations assistant for the editors of a Varbase 11 site, in the Gin admin toolbar.
  - Agent `varbase_ai_content_operations` with five Tool API and AI Agents tools: list content, list content with
    full field values, look up by a field value, list content types and vocabularies, and update one item as a new
    revision. No tool that deletes or changes the content model.
  - It answers the editors' practical questions: broken internal links and missing alt text, missing meta
    descriptions (drafted, then saved on approval), content types and terms nothing uses and near-duplicate tags,
    an editorial report by author and section with stalled drafts, and renaming a term across content with a diff.
  - It shows every change first and saves only what the editor approves, with a revision log naming the editor.
  - Answers as short lists, which the narrow toolbar chat shows well, and only the final answer, never its working.
  - `list_content_entities` is pinned to image media with `tool_usage_limits`: asked for a field an item lacks, it
    throws and ends the chat request.
  - A yes counts only for changes already shown; a bare yes saves nothing.
  - Before saving a formatted field it reads the item's format (`entity_load_by_id`, `entity_field_values`) and
    sends it back, since `entity_update` drops a format it is not given.
  - Assistant `varbase_ai_content_operations` for the Content editor, Content admin, SEO admin and Site admin
    roles, and a toolbar block shown to them.
- `tests/verify.php`: 41 checks with no AI key, including that the save tool refuses an account without edit
  access; `ask <uid> <question>` asks one real question.
- GitHub Actions CI: lint, then a real Varbase 11 site on MariaDB 11.8 that applies the recipe twice, runs
  `tests/verify.php`, and runs the functional tests in `tests/features` (Playwright and Cucumber through
  `@vardot/varbase-e2e`, in Chromium).
- README, `AGENTS.md`, `LICENSE`, `logo.png`, composer metadata, and the Vardot issue and pull request templates.

### Checked
- The five example questions, asked as a Content admin through Claude Opus on a Varbase 11 site with 21 content
  items: every planted problem found, totals correct, and every approved save verified as one revision with the
  log message and nothing else changed. See the README.

[Unreleased]: https://github.com/Vardot/varbase_ai_content_operations_base/compare/1.0.1...1.0.x
[1.0.1]: https://github.com/Vardot/varbase_ai_content_operations_base/compare/1.0.0...1.0.1
[1.0.0]: https://github.com/Vardot/varbase_ai_content_operations_base/releases/tag/1.0.0
