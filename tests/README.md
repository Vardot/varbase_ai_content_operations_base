# Varbase functional testing suite

Playwright and Cucumber through [`@vardot/varbase-e2e`](https://www.npmjs.com/package/@vardot/varbase-e2e), on a
Varbase 11 site with this recipe applied.

| Feature | Covers |
| --- | --- |
| `01-01-ai-content-operations-base-agent.feature` | The assistant and its agent: list, load and update tools, and no delete tool |
| `01-02-ai-content-operations-base-toolbar.feature` | Editors, content admins and SEO admins open the assistant from the toolbar; other users have none |

The agent tools, the toolbar button and the chat input are named selectors in `tests/selectors/ai-content-operations-base-selectors.json`.

## Run it

```bash
npm install
LAUNCH_URL=https://your-site.ddev.site npm test
```

The site needs the webmaster (`webmaster`) and one user per role, named after the role (`content_editor`,
`content_admin`, `seo_admin`, `site_admin`), all with the password in `LOGIN_PASS` (default `dD.123123ddd`).
`.gitlab-ci.yml` shows the whole setup.

## AI provider

The toolbar assistant is shown only when the site has an AI provider with a default chat model, so CI makes the
AI module's test provider (EchoAI) the default with `tests/recipes/varbase_ai_testing_provider`. No key is
needed. Scenarios tagged `@ai-provider` need a real provider with a chat model that supports tools
(`npm run test:ai-provider`); in CI they run in their own job, only when the project has an `OPENAI_API_KEY`
variable.
