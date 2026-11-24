# Agent prompt templates

All agents: `subagent_type: "general-purpose"`, `model: "haiku"`, `run_in_background: true`.
Launch all research agents in ONE message so they run in parallel.

## Research agent

```
You are research Agent <N>. First read the shared brief: <scratchpad>/research/BRIEF.md
(follow all its rules and the report structure).

YOUR SCOPE: <one sentence>.

Where/what to search (examples, extend as needed):
- <site or database>: "<query 1>", "<query 2>", …
- <named benchmarks, institutes, authors, repositories to check>
Questions to answer with data: (a) … (b) … (c) …
Extract exact numbers into tables (<columns>).

Write your report to: <scratchpad>/research/agent<N>-<slug>.md
```

## Native-language agent (one per language group)

```
You are research Agent <N>. Read the shared brief first: <scratchpad>/research/BRIEF.md

YOUR LANGUAGES: <e.g. Czech, Slovak, Slovenian, Croatian, Serbian, Bosnian>.
Requirement: at least 5 search iterations WRITTEN IN THESE LANGUAGES (not English), each with
different phrasing and different sites. Log every query verbatim with its language. Only after
the 5th unsuccessful native-language iteration may you conclude that data does not exist.

Goal: primary sources comparing <subject> in these languages vs <baseline language> on the
SAME task, preferably <years>, and any source where the language matches or beats the baseline.

Example native queries (adapt, translate, vary):
- CS: "…"   - SK: "…"   - SL: "…"   - HR/SR/BS: "…"
Where: WebSearch, ACL Anthology (<workshops>), arXiv, national university repositories
(<list>), Hugging Face leaderboards (<list>), institutes (<list>).
Concrete tasks: 1. … 2. …

Write to: <scratchpad>/research/agent<N>-<slug>.md and return it.
```

## Verifier

Launch one per report as soon as the report arrives (do not wait for the others).

```
You are verification Agent V<N>. Read the shared brief first: <scratchpad>/research/BRIEF.md
Then read the report to verify: <scratchpad>/research/agent<N>-<slug>.md

Be skeptical: the previous agent read sources through WebFetch summaries, which can invent or
misalign table rows. CONFIRM or REFUTE with verbatim evidence. Ask WebFetch to COPY VERBATIM
(not summarise) and read each key table twice with differently worded prompts; say whether the
two reads agree. Prefer PDF text extraction (see brief) for tables.

Claims to verify:
1. <source + exact claim + expected value + table location>
2. <…>
Also report: exact title, authors, date/version; how translations or datasets were produced;
sample sizes; whether significance tests exist; per-row values behind any average.

Output per claim: CONFIRMED (verbatim + location) / CORRECTED (correct value) / NOT FOUND.
Write to <scratchpad>/research/verify<N>-<slug>.md and return it.
```

## Follow-up: citations of the primary source

```
You are research Agent <N>b. Read the brief and <previous report>.
Goal: newer evidence by checking papers that cite <primary source arXiv id>.
1. Pull the citations list (Semantic Scholar API, see brief); shortlist papers from
   <years> whose title/abstract matches <topic>.
2. For each shortlisted paper with <target languages>: open the HTML/PDF and extract
   per-language numbers (language | model | task | metric | value | location).
3. Treat every ID skeptically: if it does not resolve or the title does not match, say so.
Write to <scratchpad>/research/agent<N>b-citers.md and return it.
```

## Feedback messages (examples)

- "Your previous attempt searched almost only in English. Requirement: 5 iterations in the
  native languages, logged verbatim. Re-run with Czech/Slovak/... queries only."
- "Agents 1 and 2 disagree on whether the 88% average covers all context lengths or only 64K
  and 128K. Quote the exact sentence and its location."
- "A PDF extractor is now available: <PDF_PYTHON> -I <PDF_SCRIPT> <pdf> <out.txt>."
  (send only to agents that are still running)
