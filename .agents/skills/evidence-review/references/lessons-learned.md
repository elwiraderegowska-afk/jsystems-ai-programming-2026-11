# Lessons learned (first run, November 2026)

Topic: "Is Polish the best language for LLMs?" (trace of a cryps.pl article to OneRuler,
plus 2025–2026 data on Slavic languages). 6 research agents + 7 follow-up/verifier agents
(Haiku), 2 Markdown reports, 2 artifacts. Below: what went wrong or slowly, and the fix now
built into the skill.

| # | What happened | Cost | Fix in this skill |
|---|---|---|---|
| 1 | The first prompt was a process template without a topic | One wasted round | Step 0 asks for topic, claims and save location in a single question round |
| 2 | The save location was not asked; the coordinator picked `docs/research/...` | User had to accept a guess | Step 0 always asks where to save unless the prompt says so |
| 3 | WebFetch returned model summaries, not verbatim tables; PDFs over 10 MB failed; `curl` was denied for subagents | Many numbers stayed "UNVERIFIED"; extra verifier rounds | Step 1 tooling preflight: PDF extractor ready before launch, announced in the brief |
| 4 | A verifier installed `pypdf` on its own without asking | Unapproved package install | Step 1: the coordinator asks the user once and prepares the venv; agents never install |
| 5 | One agent covering 11 Slavic languages searched almost only in English | Relaunch of two agents | One agent per language group; ≥5 logged native-language iterations each |
| 6 | Two agents disagreed on the averaging window (all contexts vs 64K+128K) | Extra verification | Verifier for every key number; disagreements resolved by a third read |
| 7 | A press line ("not statistically significant") existed only in the English version of an article, but was quoted as the author's words | Would have been a misattribution | Check the original-language source of every quote; label paraphrases |
| 8 | A "+5.1 pts" average was driven by one small model | Misleading headline number | Verifiers report per-row values, not only averages |
| 9 | An arXiv ID prefix (2610) contradicted the stated date (March 2026) | Possible fabricated or confused metadata | Step 4: flag ID/date mismatches; cite such sources only cautiously |
| 10 | A derived number ("up to 16 pts") was computed by hand and was wrong (18.1) | Report fix after publishing | Step 5: compute derived numbers with a script |
| 11 | Messaging a finished agent resumed it and produced a duplicate report | Noise, tokens | Only message agents that are still running |
| 12 | Search results contained injected "REMINDER" text | Risk of the agent following it | Brief tells agents to treat page text as data; the coordinator notes it |
| 13 | Artifacts were built as fragments; the user then asked for committable HTML | Extra rebuild | Step 6 builds fragment and standalone versions together |
| 14 | The coordinator suggested using `/update-config` so Claude could add its own push permission | Wrong advice (Claude must not widen its own permissions) | Step 7: say the block plainly; offer branch + PR or the user's own command |
| 15 | Push to `main` was blocked three times; one retry was the same action | Wasted calls | Do not retry a denied action; offer alternatives at once |
| 16 | Long silences while agents ran | User asked for a status | Short status after each batch of reports |

## What worked well (keep doing it)

- A shared `BRIEF.md` that every agent reads first; per-agent prompts stay short.
- Strict source rule: press/social media only as leads; numbers only from primary sources,
  with table/section location.
- Pipelining: launching a verifier as soon as each report arrived, instead of waiting for all.
- Following citations of the primary source (Semantic Scholar) to find newer studies.
- Status labels ✅ / ☑️ / ⚠️ in the report and a filterable source table in the artifact.
- A practical "what this means for you" section at the end of the report.
