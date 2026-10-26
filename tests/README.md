# Varbase functional testing suite

Playwright and Cucumber through [`@vardot/varbase-e2e`](https://www.npmjs.com/package/@vardot/varbase-e2e), on a
Varbase 11 site with this recipe applied.

| Feature | Covers |
| --- | --- |
| `01-01-ai-content-operations-base-toolbar.feature` | Each editorial role opens the assistant from the toolbar; a signed-in user without an editorial role has none; an editor asks it about the site's content and gets an answer |
| `01-02-ai-content-operations-base-accessibility.feature` | The content page with the assistant gives every field a label and every link a name |

The toolbar button, the consent button and the chat input are named selectors in `tests/selectors/ai-content-operations-base-selectors.json`.

## Run it

```bash
npm install
LAUNCH_URL=https://your-site.ddev.site npm test
```

The site needs the webmaster (`webmaster`) and one user per role, named after the role (`content_editor`,
`content_admin`, `seo_admin`, `site_admin`), all with the password in `LOGIN_PASS` (default `dD.123123ddd`).
`.gitlab-ci.yml` shows the whole setup.

## AI provider

CI applies Drupal CMS AI before the recipe. It sets up an amazee.ai trial as the default provider, so no key
is needed and the assistant answers from a real model. Drupal CMS AI asks before the chat assistant loads; the
scenarios answer "Yes (this time)", as an editor would.
