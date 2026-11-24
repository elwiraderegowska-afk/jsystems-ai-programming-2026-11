# Report template

Write `report.en.md` first, then `report.pl.md` (a full translation, not a summary; numbers
use a decimal comma in Polish). Save both in the folder the user chose in step 0.
A finished example lives in the repo at `docs/research/llm-language-effect/report.en.md`.

```markdown
# <Question as a title> (<month year>)

**Question.** <What triggered the review (link), what we checked, the core question.>

**Short answer.**
1. <Primary source + its exact headline number + what it does NOT show.>
2. <Main finding across newer sources.>
3. <Where the effect holds / does not hold.>
4. <Practical cost or risk, if any.>

**Practical guidance.** <2–3 sentences: what to do differently.>

---

## How this review was done
- <N> research and verification agents (Claude Haiku); sites searched.
- Search languages and the number of iterations per language group.
- Evidence = primary sources only; leads = press/social.
- Status labels: ✅ verified (second agent) · ☑️ read once · ⚠️ unverified (abstract/figure/press).

## 1. The primary source of the claim
| Item | Value | Status |
**What the source does not support** (bullets)
**What the authors said afterwards** (exact attribution: who, where, language version)

## 2–5. One section per area
Short intro, one table per source with exact numbers, a one-line conclusion per section.

## 6. Context (domain-specific benchmarks)

## 7. Evidence matrix
| Area | Result vs baseline | Strength of evidence |
**Answer to the core question.** <2–3 sentences.>

## 8. Open gaps

## Sources
| Id | Source (authors, title, id/URL) |
```

## Rules

- Every number has a status label; derived numbers are computed by a script.
- Keep the evidence matrix honest: one study = weak, even if the effect looks big.
- Separate "no evidence found" from "evidence of no effect".
- Press items appear only under "what the authors said" or in sources as leads.
