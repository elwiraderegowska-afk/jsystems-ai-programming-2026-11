# Is Polish the best language for LLMs? Evidence review (November 2026)

**Question.** A Polish popular-science article ([cryps.pl, 25 Oct 2025](https://cryps.pl/sztuczna-inteligencja-mowi-po-polsku-nasz-jezyk-zdeklasowal-angielski-w-najnowszym-rankingu/)) reported that Polish "beat English" in a 2025 LLM ranking. We traced the primary source, then looked for newer (2025–2026) data on Polish, other Slavic languages and English in three areas: information retrieval and RAG, reasoning, and agentic tasks. The core question is whether the language of a prompt changes how well an LLM agent reasons.

**Short answer.**

1. The article is based on **OneRuler** (Kim, Russell, Karpińska, Iyyer; arXiv:2503.01996). On synthetic needle-in-a-haystack retrieval at 64K–128K tokens, Polish averaged **88%** and English **83.9%** (6th of 26). The paper tests no prompting advice, reasoning or agents. Its own co-author said in a PAP interview that the team "did not study that at all".
2. No 2025–2026 source we found shows Polish, or any other Slavic language, outperforming English on reasoning, instruction following, tool use or agentic tasks. In those areas English is equal or better.
3. For **frontier models** the gap on reasoning is now small, often within noise. Older and smaller models, specialised models, instruction following and agent benchmarks still show clear English advantages.
4. Polish costs **about 1.7–1.9× more tokens** than English for the same text on mainstream tokenizers. That cost is real and measurable, regardless of quality.

**Practical guidance for developers.** Writing prompts in Polish does not make a frontier model reason better or worse in any measurable way. Keep instructions, tool schemas and `CLAUDE.md`/`AGENTS.md` in English when token budget or instruction-following precision matters. Use Polish where the content, the users or the output must be Polish.

---

## How this review was done

- 13 research and verification agents (Claude Haiku) searched arXiv, the ACL Anthology, OpenReview, NeurIPS, Semantic Scholar, Hugging Face, GitHub, institute sites and university repositories.
- Searches ran in English, Polish, Czech, Slovak, Slovenian, Croatian, Serbian, Bosnian, Ukrainian, Russian, Belarusian, Bulgarian and Macedonian. Each language group got **at least 5 search iterations** (Polish 21, West/South Slavic 13, East Slavic and Bulgarian 11).
- **Only primary sources count as evidence**: papers, technical reports and benchmark tables. Press, blogs and forums were used only to find primary sources.
- Each key number was re-read by an independent verification agent. Tables were read twice, and PDFs were text-extracted locally where possible. Status labels used below:
  - ✅ **verified**: confirmed in the primary source by a second agent.
  - ☑️ **read once**: taken from the primary source, not independently re-read.
  - ⚠️ **unverified**: abstract, figure or press only.

---

## 1. The source of the "Polish is best" headline: OneRuler

| Item | Value | Status |
|---|---|---|
| Paper | Kim, Russell, Karpińska, Iyyer. *One ruler to measure them all: Benchmarking multilingual long-context language models*. arXiv:2503.01996, v1 3 Mar 2025, v3 30 Sep 2025. Affiliations: Univ. of Maryland, Microsoft, UMass Amherst. COLM 2025 per press only | ✅ |
| Setup | 26 languages; 7 synthetic tasks (5 needle-in-a-haystack variants, 2 common-word extraction); contexts 8K / 32K / 64K / 128K; 50 examples per configuration | ✅ |
| Models | Qwen 2.5 7B and 72B, Llama 3.1 8B, Llama 3.3 70B, Gemini 1.5 Flash, o3-mini-high (DeepSeek-R1 English only) | ✅ |
| **Polish, NIAH average at 64K + 128K** | **88%**, rank 1 of 26 | ✅ |
| **English, same window** | **83.9%**, rank 6 of 26 | ✅ |
| Chinese, same window | 62.1%, 4th worst | ✅ |
| Single model, 128K | o3-mini-high: Polish 92%, Ukrainian 89%; English 67% (the paper labels the model inconsistently) | ☑️ |
| High- vs low-resource gap | 11 pts at 8K → 34 pts at 128K (top-5 vs bottom-5 languages) | ✅ |
| Instruction-language effect | Accuracy changes by **up to 20%** depending on instruction language. English context, Korean instructions at 64K: 91% → 71%. Korean context, English instructions at 128K: 61% → 77% | ✅ |
| Haystack text | A different book per language: English *Little Women* (1868), Polish *Noce i dnie* vol. 3 (1934) | ✅ |
| Significance testing | None for the language gaps. The only p-value in the paper concerns tokenizer ranking agreement | ✅ |

**What the paper does not support**

- It does not claim Polish is better for prompting. It did not test prompting advice, reasoning or agents.
- The cryps.pl explanation based on Polish grammatical complexity does not appear in the paper. The authors discuss pretraining data, script, language family and tokenization.
- Context language and instruction language are confounded: instructions were translated into the context language.
- Per-language and per-model values exist only in figures. No result files are published in the GitHub repository.

**What the authors said afterwards** (press only; no primary statement by the authors was found)

- In PAP / Nauka w Polsce (10 Nov 2025), co-author Marzena Karpińska is quoted directly. Asked whether OneRuler showed Polish to be best for prompting, she answered no: "Wcale tego nie badaliśmy" ("We did not study that at all"). She described OneRuler as a diagnostic tool for language models.
- Spider's Web (12 Nov 2025) reports her view that the result may come from the books used, not from the language itself.
- The English PAP version, Science in Poland (27 Nov 2025), adds that the Polish–English differences were not statistically significant. This line appears only in the English text and is not a direct quote ⚠️.

---

## 2. Long-context retrieval and RAG: newer data

| Source | Languages | Finding | Status |
|---|---|---|---|
| MLRBench, Hengle et al., EACL 2026 (arXiv:2504.12845) | en, de, es, hi, ar, vi, zh (no Slavic) | Llama-3.1-8B at ≥32K: English highest (0.431 prompt / 0.503 RAG). Lowest are Chinese 0.274 and Arabic/Vietnamese 0.322 | ☑️ |
| Östling & Kurfalı, *Language Bias under Conflicting Information* (arXiv:2604.07123, Apr 2026) | zh, de, en, ru, tr; 12 models incl. GPT-5.2 | Conflicting-needle NIAH: models prefer the English needle over the Russian one | see §2.1 |
| LongBench Pro (arXiv:2601.02872, Jan 2026) | en, zh only | 46 long-context models; no Slavic data | ✅ |
| LIBRA (arXiv:2408.02439) | Russian only | GPT-4o 73.3 at 4K → 54.8 at 128K; no English baseline | ☑️ |
| MGAL (arXiv:2608.20853, Aug 2026) | 6 UN languages incl. Russian | Per-language results only in figures | ⚠️ |

**Gap.** We found no 2025–2026 study of Claude 4.x/5, GPT-5.x or Gemini 3 that compares Polish with English on long-context retrieval, and no replication of OneRuler. The OneRuler result therefore rests on 2025-era models only.

### 2.1 Which language does the model trust? (2026)

Östling & Kurfalı, arXiv:2604.07123 (v2, Jun 2026). Two needles with conflicting facts are hidden in the same haystack, each in a different language. The needles were machine-translated. The study tests 12 models, including GPT-5.2, GPT-5-mini and GPT-5-nano. At 25,000 words, every other language was preferred over Russian in 100% of posterior samples. The English-vs-Russian CI is [2.01, 3.64]. The authors conclude that information in Russian is "strongly dispreferred" compared with all other languages tested. Polish was not tested. ✅

MGAL (arXiv:2608.20853, Aug 2026) evaluated GPT-5 on 6 UN languages. Its appendix suggests large English-over-Russian gaps on harder long-context tasks: Multi-QA 82.71 vs 54.17, Cloze 52.89 vs 25.34. This comes from a single read and is not yet verified. ⚠️

The paper arXiv:2602.20065 is sometimes cited for the Polish claim. It does not test Polish; it only cites OneRuler.

---

## 3. Reasoning: does the language change the result?

### 3.1 Frontier models on the same items: near parity

**mmPISA-bench**, Sapenov & Savelka, arXiv:2606.07069 (June 2026). PISA-style multiple-choice questions in 43 languages. There are 25 questions per language, each run 5 times, so every cell is based on 125 answers. No significance tests. ✅

| Language | Claude Haiku 4.5 (no reasoning) | Claude Opus 4.5 (high effort) | GPT-5.1 (no reasoning) | GPT-5.1 (high effort) |
|---|---|---|---|---|
| English | 90.4 | 100.0 | 76.8 | 96.8 |
| **Polish** | 87.2 | 94.4 | **78.4** | 96.0 |
| Czech | 84.8 | 96.8 | 79.2 | 94.4 |
| Slovak | 88.0 | 96.0 | 74.4 | 95.2 |
| Slovenian | 89.6 | 95.2 | 80.0 | 96.0 |
| Croatian | 88.8 | 96.8 | 78.4 | 96.0 |
| Serbian | 87.2 | 99.2 | 77.6 | 96.0 |
| Bulgarian | 85.6 | 96.8 | 84.0 | 90.4 |
| Russian | 85.6 | 95.2 | 84.8 | 94.4 |

Polish trails English by 1–7 answers out of 125 and leads it in one column, which is within noise. The "no reasoning" and "high effort" Claude columns use different models (Haiku vs Opus).

**Mind the Gap… or Not?**, Peter, Vilar, Domhan, Malkin, Freitag (Google), arXiv:2511.05162 (Nov 2025, v2 Jun 2026). The authors re-translated faulty MGSM math questions and relaxed answer extraction. The original language gap "mostly disappears". ✅

| Model | EN − RU gap, original (pts) | EN − RU gap, corrected (pts) |
|---|---|---|
| Gemini 2.5 Pro | 2.4 | 0.0 |
| GPT-5 | 2.4 | 0.0 |
| Claude Sonnet 4.5 | 3.2 | −0.4 |
| Claude Haiku 4.5 | 4.0 | 0.4 |
| DeepSeek R1 | 2.4 | 0.4 |
| DeepSeek V3 | 4.8 | 2.0 |
| Gemma 3 27B | 6.0 | 3.2 |
| Gemma 3 12B | 4.4 | 2.8 |

Large gaps remain for low-resource languages. For example, GPT-OSS-20B still trails by 18.4 pts on Swahili. Part of the "English advantage" reported for multilingual benchmarks is a translation and evaluation artefact.

**PolyMath** (arXiv:2504.18428, NeurIPS 2025). Russian vs English on frontier reasoning models: English leads by 0.8–6.4 pts across difficulty levels (for example, Qwen3-235B-Thinking "high" level: 66.4 vs 60.0). Polish is not included. ✅

### 3.2 Smaller and specialised models: English still clearly ahead

**Polish medical licensing exams**, Grzybowski et al., arXiv:2412.00559 v2 (Sep 2025). The same exam questions in Polish and in official English versions translated by medical experts from the exam centre. English scores higher for **13 of 16 models** on both LEK and LDEK. ✅

| Model | LEK PL | LEK EN |
|---|---|---|
| GPT-4o (2024-08) | **89.96** | 88.69 |
| Llama-3.1-70B | 80.94 | 82.60 |
| Qwen2.5-72B | 76.87 | 81.93 |
| Mistral-Large-2407 | 76.75 | 82.40 |
| GPT-4o-mini | 75.88 | 75.92 |
| Bielik-11B v2.2 | **62.36** | 56.98 |
| Qwen2.5-7B | 51.92 | 67.73 |
| Llama-3.1-8B | 51.25 | 64.69 |

The gap shrinks as models grow. GPT-4o and the Polish model Bielik score higher in Polish.

**Bulgarian MMLU**, Koeva et al., LREC 2026. MMLU-BG vs the original English MMLU (8-bit results): Gemma-3-27B 78.1 vs 72.7; Qwen2.5-14B 75.0 vs 64.2; BgGPT-9B 62.7 vs 56.1. Gaps are smaller for models pretrained with Bulgarian. ✅

**BgGPT 1.0** (arXiv:2412.10893). 12 open models; English average beats Bulgarian average by 8.5–22.4 pts. ✅

### 3.3 Should the model reason in English?

**Language Matters**, Tam et al., arXiv:2505.17407. Forcing reasoning in English vs in the question language, MATH-500. Russian average: 86.7 vs 81.6 (+5.1). One 8B model contributes +19.0 of that average. The three larger models differ by only 0.2–0.6 pts. Low-resource languages gain much more: Swahili +31.5. ✅

**Crosslingual reasoning through test-time scaling** (arXiv:2505.05408). Reasoning in high-resource languages is within 1–2 pts of English. ☑️

**Do multilingual LLMs think in English?** (arXiv:2502.15603). Logit-lens analysis shows 50–70% of intermediate representations route through English. No Slavic language was tested. ☑️

**Conclusion for Polish.** No study tested forced English vs forced Polish reasoning. The Russian data suggests the effect is negligible for large models.

### 3.4 Classification (South Slavic)

Kuzman Pungeršek et al., arXiv:2511.07989 v2 (Feb 2026). Zero-shot classification of parliamentary texts. English beats the South Slavic average (Slovenian, Croatian, Serbian, Bosnian, Macedonian) on every model, but only slightly. Macro-F1 gap, sentiment / topic: GPT-5 0.02 / 0.05; GPT-4o 0.04 / 0.08; Gemini 2.5 Flash 0.04 / 0.08; Qwen 3 0.07 / 0.10. ✅

---

## 4. Agents, tools and instruction following

| Source | Finding | Status |
|---|---|---|
| **MAPS**, arXiv:2505.15935 v3 (Feb 2026): GAIA and other agent benchmarks in 11 languages + EN (no Polish) | GAIA accuracy: English **47.4%** vs non-English mean **35.8%** (−11.6 pts). Russian: GPT-o1 39.1 vs EN 47.3; GPT-4o 32.7 vs EN 40.1. Agent security (ASB) attack success: EN 32.7 vs non-EN 47.3, so non-English prompts are also less safe | ✅ |
| **Marco-Bench-MIF**, arXiv:2507.11882: instruction following, 25 models | Average across models: EN **76.2**, PL **58.6**, CS 64.0, RU 63.6, UK 58.5. Claude 3.5 Sonnet: EN 90.3 / PL 74.5. GPT-4o: EN 87.8 / PL 73.0 | ✅ |
| **Language Equality has a Price**, Hakimov et al., arXiv:2608.01395 (Aug 2026): multi-turn dialogue games, EU-24+, 9 current models (clemscore 0–100) | Polish **below** English on 7 of 9 models. GPT-5.4: PL 89.5 / EN 91.8. Opus-4.8: 82.3 / 84.4. Nemotron: 57.1 / 68.2. Qwen3.6: 45.9 / 55.6. Polish above English only for Gemma4 (59.7 / 50.6) and Apertus (22.0 / 21.4). Model average: EN 61.9, PL 59.2, RU 59.4 | ✅ |
| **Brittle Compass**, Harvan et al., arXiv:2611.01219 (RANLP-LowResNLP 2025): Slovak vs English prompts, 9 models × 3 methods | Slovak prompts slightly better only for location extraction (0.810 vs 0.792, CI 0.003–0.033). Theme and geo tasks: no significant difference | ✅ |
| **MLCL**, arXiv:2601.05366: multilingual tool calling (zh, hi, ig) | Typical failure: parameter values left in the user's language. Pre-translation helps, but no strategy reaches English level | ☑️ |

**Conclusion.** For agents, the evidence points one way: English instructions are equal or better. No source shows an advantage for Polish or any other Slavic language.

---

## 5. Cost: tokens per language

| Source | Measurement | Polish | Other Slavic | English | Status |
|---|---|---|---|---|---|
| Ovcharov, *The Tokenizer Tax*, arXiv:2605.24718 (May 2026), SIB-200, 6 tokenizers incl. GPT-4o o200k | tokens per word | **2.25** (1.88–2.60) | CS 2.28, SL 2.28, HR 2.31, BG 2.33, SK 2.45, UK 2.66 | **1.23** | ✅ |
| Petrov et al., NeurIPS 2023 (arXiv:2305.15425), FLORES-200, cl100k (GPT-4) | premium vs English | **1.91×** | CS 2.11, SK 2.14, SL 1.88, RU 2.49, UK 3.00, BG 2.64 | 1.00 | ✅ |
| Bielik v3 report, arXiv:2505.02550: Polish Constitution preamble, PL vs EN | total tokens | Mistral v0.1: 747 vs 408 (1.83×). Qwen2.5: 625 vs 373 (1.68×). Polish APT4 tokenizer: 375 vs 631 | – | – | ✅ |

There is no published primary measurement for Claude tokenizers. It can be measured with Anthropic's token-counting API on FLORES-200.

**Practical meaning.** The same `CLAUDE.md` written in Polish takes roughly 1.7–1.9× more of the context window and costs proportionally more per call.

---

## 6. Polish-specific benchmarks (context)

- **PLCC** (Polish linguistic and cultural competence, arXiv:2503.00995, Mar 2025): Gemini-Exp-1206 83.00, Claude 3.5 Sonnet 82.67, GPT-4o 81.33, Bielik-2.3 11B 62.17. Newer leaderboard values (HF `sdadas/plcc`) could not be read. ☑️
- **Bielik reasoning field report** (arXiv:2603.10640, Mar 2026), 111 Polish logic puzzles: Gemini-3-pro-preview 87%, o3 87%, Gemini-2.5-pro 84%, Bielik-R 56%. ✅
- **MiniCzechBenchmark** (NeurIPS 2025). The abstract reports a "10–30%" gap between English and Czech. Per-model numbers are not accessible. ⚠️
- These benchmarks are Polish-only (or Czech-only), so they cannot answer the "PL vs EN" question on their own.

---

## 7. Evidence matrix

| Area | Polish / Slavic vs English | Strength of evidence |
|---|---|---|
| Long-context retrieval (NIAH) | Polish slightly **above** English (88 vs 83.9), 2025 models, synthetic task, confounded by books, no significance test | weak, single study |
| Long-context with conflicting info | Russian **below** English (models prefer the English source) | single 2026 study |
| Reasoning, frontier models | **≈ parity** (within 1–7 answers out of 125; MGSM gap ≈ 0 after correction) | moderate |
| Reasoning, small and medium models | English **ahead** (up to 18 pts on Polish medical exams) | moderate–strong |
| Instruction following | English **ahead** (PL 58.6 vs EN 76.2 average) | moderate |
| Multi-turn interaction, 2026 frontier models | Polish slightly **below** English (−2.3 pts for GPT-5.4, −2.1 for Opus-4.8) | moderate, single 2026 study |
| Agentic tasks | English **ahead** (GAIA −11.6 pts for non-English); non-English prompts less safe | moderate (no Polish data) |
| Token cost | Polish **1.7–1.9× more** tokens | strong |

**Answer to "does the language affect the agent's reasoning?"** For frontier models in 2025–2026: barely, on reasoning itself. Yes, on instruction following, tool calling and agent reliability, where English instructions remain better. Polish never shows a reproducible advantage outside one synthetic retrieval benchmark.

---

## 8. Open gaps

- OneRuler per-language and per-model numbers exist only in figures. No result files are published.
- No 2026 Polish-vs-English long-context or agent benchmark on Claude 4.x/5, GPT-5.x or Gemini 3 was found.
- No primary statement from the OneRuler authors (blog, erratum, social post) was found, only press interviews.
- Claude tokenizer cost for Polish is unpublished.
- BenchMAX per-language Czech, Serbian and Russian scores are figure-only.

## Sources

| Id | Source |
|---|---|
| S1 | Kim, Russell, Karpińska, Iyyer. One ruler to measure them all. arXiv:2503.01996 — https://arxiv.org/abs/2503.01996 |
| S2 | Hengle et al. Can LLMs reason over extended multilingual contexts? (MLRBench), EACL 2026 — https://arxiv.org/abs/2504.12845 |
| S3 | Östling, Kurfalı. Language Bias under Conflicting Information in Multilingual LLMs. arXiv:2604.07123 |
| S4 | Sapenov, Savelka. mmPISA-bench. arXiv:2606.07069 — https://arxiv.org/abs/2606.07069 |
| S5 | Peter et al. Mind the Gap… or Not? arXiv:2511.05162 — https://arxiv.org/abs/2511.05162 |
| S6 | PolyMath. arXiv:2504.18428 — https://arxiv.org/abs/2504.18428 |
| S7 | Grzybowski et al. Polish medical exams, arXiv:2412.00559 v2 — https://arxiv.org/abs/2412.00559 |
| S8 | Koeva et al. Bulgarian MMLU, LREC 2026 — https://aclanthology.org/2026.lrec-1.366/ |
| S9 | BgGPT 1.0. arXiv:2412.10893 |
| S10 | Tam et al. Language Matters. arXiv:2505.17407 |
| S11 | Crosslingual Reasoning through Test-Time Scaling. arXiv:2505.05408 |
| S12 | Schut et al. Do Multilingual LLMs Think in English? arXiv:2502.15603 |
| S13 | Kuzman Pungeršek et al. Text classification for South Slavic languages. arXiv:2511.07989 |
| S14 | MAPS. arXiv:2505.15935 |
| S15 | Marco-Bench-MIF. arXiv:2507.11882 |
| S16 | Harvan et al. The Brittle Compass. arXiv:2611.01219 |
| S17 | MLCL multilingual tool calling. arXiv:2601.05366 |
| S18 | Ovcharov. The Tokenizer Tax. arXiv:2605.24718 |
| S19 | Petrov et al. Language Model Tokenizers Introduce Unfairness Between Languages. arXiv:2305.15425 |
| S20 | Bielik v3 Small technical report. arXiv:2505.02550 |
| S21 | PLCC. arXiv:2503.00995 |
| S22 | Trybus, Bartnicki, Kinas. Making Bielik LLM Reason (Better). arXiv:2603.10640 |
| S23 | MiniCzechBenchmark, NeurIPS 2025 — https://neurips.cc/virtual/2025/122449 |
| S25 | Hakimov et al. Language Equality has a Price (EU-24+). arXiv:2608.01395 |
| S24 | MLRBench / LongBench Pro arXiv:2601.02872; LIBRA arXiv:2408.02439; MGAL arXiv:2608.20853 |
| P1 | Press (leads only): Nauka w Polsce / PAP, 10 Nov 2025 interview with M. Karpińska; Science in Poland, 27 Nov 2025; Spider's Web, 12 Nov 2025 |
