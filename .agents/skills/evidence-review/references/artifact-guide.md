# Artifact guide

Goal: one interactive page per language that makes the evidence easy to grasp, plus
standalone HTML copies of both for the repo.

## Before writing

1. `Artifact action: "quickstart", intent: "other", design_systems: false`: gives the page
   contract (no doctype/head/body in the published file, CDN allowlist, theme tokens).
2. Load the `dataviz` skill and validate the chart palette with its
   `scripts/validate_palette.js` in light and dark mode. With a contrast warning, give every
   chart direct labels and a table view.

## Structure that worked

Start from `assets/example-page.html` (finished example: Polish vs English in LLMs).
It is a single template with:

- `const LANG = "__LANG__"` and `<title>__TITLE__</title>` placeholders,
- a `D` object with all verified data (only numbers from the report),
- a `T = { pl: {...}, en: {...} }` object with all copy in both languages,
- hand-built SVG charts (horizontal bars, dumbbells) with hover tooltips, segmented
  toggles (model / mode / before-after), `<details>` table views,
- a hero "what the media said vs what the data shows" block,
- an evidence matrix with verdict chips and 1–5 strength bars,
- an interactive calculator where the topic allows (e.g. token cost),
- a sources table filterable by verification status,
- a "what this means for you" list.

Colour roles: baseline language = blue, the user's language = orange, other languages in the
group = aqua, out-of-group = neutral grey. Text never uses series colours.

## Build both outputs

```bash
bash .agents/skills/evidence-review/scripts/build_pages.sh <template.html> <scratchpad>/artifact <report-folder> <slug> "<PL title>" "<EN title>"
```

This writes:
- `<scratchpad>/artifact/<slug>.pl.html` and `.en.html`: fragments to publish with the Artifact tool,
- `<report-folder>/<slug>.pl.html` and `.en.html`: standalone documents for the repo.

Check once in the browser pane (console errors, 0 horizontal overflow, chart count), then
publish both fragments with `icon: "chart"` and a one-sentence `description`.
To republish later, rebuild and publish the same fragment paths (or pass the artifact `url`).
