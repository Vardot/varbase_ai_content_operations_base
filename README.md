[![Varbase](https://raw.githubusercontent.com/Vardot/varbase/11.0.x/images/varbase-logo.png)](https://www.drupal.org/project/varbase)

# Varbase AI Content Operations Base
[![Varbase AI Content Operations Base](https://img.shields.io/badge/Varbase%20AI%20Content%20Operations%20Base-1.0.0--alpha1-0d6efc?labelColor=001d38&style=flat-square)](https://www.drupal.org/project/varbase_ai_content_operations_base)

An **opt-in** Drupal recipe that gives the editors of a Varbase 11 site a **content operations assistant**
in the admin toolbar. Editors ask in their own words, and it audits, reports on and updates the site's content:

## Documentation

Read the [Varbase AI Content Operations Base documentation](https://docs.varbase.vardot.com/developers/understanding-varbase/varbase-ai-recipes/varbase-ai-content-operations-base) on the Varbase docs site.

## Install and apply

```bash
# 1. Fetch the recipe.
ddev composer config --json extra.drupal-recipe-unpack.ignore '["drupal/varbase_ai_content_operations_base"]'
ddev composer require drupal/varbase_ai_content_operations_base:~1

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

## License

GPL-2.0-or-later. See [LICENSE](LICENSE).
