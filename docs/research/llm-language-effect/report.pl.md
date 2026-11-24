# Czy polski to najlepszy język dla LLM? Przegląd dowodów (listopad 2026)

**Pytanie.** Artykuł popularnonaukowy na [cryps.pl (25.10.2025)](https://cryps.pl/sztuczna-inteligencja-mowi-po-polsku-nasz-jezyk-zdeklasowal-angielski-w-najnowszym-rankingu/) podał, że polski „zdeklasował angielski” w rankingu modeli językowych z 2025 roku. Najpierw ustaliliśmy źródło pierwotne tej informacji. Potem szukaliśmy nowszych danych z lat 2025–2026, które porównują polski i inne języki słowiańskie z angielskim w trzech obszarach: wyszukiwanie informacji i RAG, rozumowanie oraz zadania agentowe. Pytanie główne brzmi: czy język promptu wpływa na jakość rozumowania agenta?

**Krótka odpowiedź.**

1. Artykuł opiera się na benchmarku **OneRuler** (Kim, Russell, Karpińska, Iyyer; arXiv:2503.01996). W syntetycznym wyszukiwaniu „igły w stogu siana” przy kontekście 64K–128K tokenów polski uzyskał średnio **88%**, a angielski **83,9%** (6. miejsce na 26 języków). Praca nie bada promptowania, rozumowania ani agentów. Współautorka powiedziała w wywiadzie dla PAP: „Wcale tego nie badaliśmy”.
2. W żadnym źródle z lat 2025–2026 polski ani inny język słowiański nie wypada lepiej od angielskiego w rozumowaniu, wykonywaniu instrukcji, używaniu narzędzi czy zadaniach agentowych. W tych obszarach angielski jest równy albo lepszy.
3. W rozumowaniu **najnowszych modeli** różnica jest dziś mała, często w granicach szumu. Wyraźna przewaga angielskiego utrzymuje się w starszych i mniejszych modelach, w modelach wyspecjalizowanych, przy wykonywaniu instrukcji i w benchmarkach agentowych.
4. Ten sam tekst po polsku zajmuje **ok. 1,7–1,9 razy więcej tokenów** niż po angielsku w popularnych tokenizerach. To realny i mierzalny koszt, niezależny od jakości odpowiedzi.

**Wskazówki praktyczne dla programistów.**
- Pisanie promptów po polsku nie sprawia w mierzalny sposób, że najnowszy model rozumuje lepiej albo gorzej.
- Instrukcje, schematy narzędzi oraz pliki `CLAUDE.md` i `AGENTS.md` warto trzymać po angielsku, gdy liczy się budżet tokenów i precyzja wykonywania instrukcji.
- Polskiego używaj tam, gdzie polskie są treść, użytkownicy albo oczekiwany wynik.

---

## Jak powstał ten przegląd

- 13 agentów badawczych i weryfikujących (Claude Haiku) przeszukało arXiv, ACL Anthology, OpenReview, NeurIPS, Semantic Scholar, Hugging Face, GitHub, strony instytutów i repozytoria uczelni.
- Zapytania prowadzono po angielsku, polsku, czesku, słowacku, słoweńsku, chorwacku, serbsku, bośniacku, ukraińsku, rosyjsku, białorusku, bułgarsku i macedońsku. Każda grupa języków przeszła **co najmniej 5 iteracji wyszukiwania**: polski 21, zachodnio- i południowosłowiańskie 13, wschodniosłowiańskie z bułgarskim 11.
- **Dowodem są wyłącznie źródła pierwotne**: publikacje, raporty techniczne i tabele benchmarków. Prasa, blogi i fora posłużyły tylko do znalezienia źródeł.
- Każdą kluczową liczbę ponownie odczytał niezależny agent weryfikujący. Tabele czytano dwukrotnie, a PDF-y, gdy było to możliwe, przetwarzano lokalnie na tekst.

Oznaczenia:
- ✅ **zweryfikowane**: drugi agent potwierdził liczbę w źródle pierwotnym,
- ☑️ **odczytane raz**: liczba pochodzi ze źródła pierwotnego, ale nikt jej niezależnie nie sprawdził,
- ⚠️ **niezweryfikowane**: tylko abstrakt, wykres albo prasa.

---

## 1. Skąd nagłówek „polski najlepszy”: OneRuler

| Element | Wartość | Status |
|---|---|---|
| Publikacja | Kim, Russell, Karpińska, Iyyer, *One ruler to measure them all: Benchmarking multilingual long-context language models*, arXiv:2503.01996 (v1 3.03.2025, v3 30.09.2025). Afiliacje: Univ. of Maryland, Microsoft, UMass Amherst. COLM 2025 wymienia tylko prasa | ✅ |
| Projekt badania | 26 języków; 7 zadań syntetycznych (5 wariantów „igły w stogu siana”, 2 zadania ekstrakcji najczęstszych słów); kontekst 8K / 32K / 64K / 128K; 50 przykładów na konfigurację | ✅ |
| Modele | Qwen 2.5 7B i 72B, Llama 3.1 8B, Llama 3.3 70B, Gemini 1.5 Flash, o3-mini-high (DeepSeek-R1 tylko po angielsku) | ✅ |
| **Polski, średnia NIAH dla 64K + 128K** | **88%**, 1. miejsce na 26 | ✅ |
| **Angielski, to samo okno** | **83,9%**, 6. miejsce na 26 | ✅ |
| Chiński, to samo okno | 62,1%, 4. miejsce od końca | ✅ |
| Jeden model, 128K | o3-mini-high: polski 92%, ukraiński 89%; angielski 67% (praca niespójnie nazywa ten model) | ☑️ |
| Różnica między językami o dużych i małych zasobach | 11 pkt przy 8K → 34 pkt przy 128K (5 najlepszych wobec 5 najsłabszych języków) | ✅ |
| Wpływ języka instrukcji | Dokładność zmienia się **nawet o 20%** w zależności od języka instrukcji. Przykłady: kontekst angielski z instrukcjami po koreańsku przy 64K: 91% → 71%; kontekst koreański z instrukcjami po angielsku przy 128K: 61% → 77% | ✅ |
| Tekst w „stogu siana” | Inna książka dla każdego języka: angielski *Little Women* (1868), polski *Noce i dnie*, t. 3 (1934) | ✅ |
| Testy istotności | Różnic między językami nie testowano. Jedyna wartość p w pracy dotyczy zgodności rankingów tokenizerów | ✅ |

**Czego praca nie pokazuje**

- Nie twierdzi, że polski jest lepszy do promptowania. Nie badano promptowania, rozumowania ani agentów.
- W pracy nie ma wyjaśnienia z cryps.pl o złożoności gramatyki polskiej. Autorzy omawiają dane treningowe, alfabet, rodzinę językową i tokenizację.
- Wpływu języka kontekstu nie da się oddzielić od wpływu języka instrukcji, bo instrukcje tłumaczono na język kontekstu.
- Wyniki dla poszczególnych języków i modeli są tylko na wykresach. Repozytorium GitHub nie zawiera plików z wynikami.

**Co autorzy powiedzieli później** (tylko w prasie; nie znaleźliśmy wypowiedzi w źródle pierwotnym, np. wpisu autorów ani erraty)

- Nauka w Polsce / PAP, 10.11.2025, wywiad z Marzeną Karpińską pod tytułem „nie pokazaliśmy wcale, że język polski jest najlepszy do promptowania”. Na pytanie o promptowanie odpowiada: „Wcale tego nie badaliśmy”. OneRuler opisuje jako narzędzie do diagnozowania modeli.
- Spider's Web, 12.11.2025: według Karpińskiej wynik mógł wynikać z charakteru użytych książek, a nie z cech samego języka.
- Angielska wersja PAP (Science in Poland, 27.11.2025) dodaje, że różnice PL–EN nie były istotne statystycznie. Tego zdania nie ma w polskim oryginale i nie jest ono cytatem bezpośrednim ⚠️.

---

## 2. Długi kontekst i RAG: nowsze dane

| Źródło | Języki | Wynik | Status |
|---|---|---|---|
| MLRBench, Hengle i in., EACL 2026 (arXiv:2504.12845) | en, de, es, hi, ar, vi, zh (bez słowiańskich) | Llama-3.1-8B przy kontekście ≥32K: najwyżej angielski (0,431 sam prompt / 0,503 z RAG); najniżej chiński 0,274 oraz arabski i wietnamski po 0,322 | ☑️ |
| Östling i Kurfalı (arXiv:2604.07123, 2026) | zh, de, en, ru, tr; 12 modeli, w tym GPT-5.2 | Przy sprzecznych „igłach” modele wolą angielską niż rosyjską (szczegóły w §2.1) | ✅ |
| LongBench Pro (arXiv:2601.02872, 01.2026) | tylko en i zh | 46 modeli długiego kontekstu; brak danych dla języków słowiańskich | ✅ |
| LIBRA (arXiv:2408.02439) | tylko rosyjski | GPT-4o: 73,3 przy 4K → 54,8 przy 128K; brak porównania z angielskim | ☑️ |

### 2.1 Któremu językowi model ufa bardziej? (2026)

Östling i Kurfalı, arXiv:2604.07123 (v2, 06.2026). W jednym długim tekście ukryto dwie sprzeczne informacje, każdą w innym języku. Wersje nieangielskie przetłumaczono maszynowo. Badanie objęło 12 modeli, w tym GPT-5.2, GPT-5-mini i GPT-5-nano. Przy 25 000 słów każdy inny język był preferowany wobec rosyjskiego w 100% próbek (przedział dla pary angielski–rosyjski: [2,01; 3,64]). Autorzy piszą, że informacja po rosyjsku jest „silnie niepreferowana”. Polskiego nie testowano. ✅

MGAL (arXiv:2608.20853, 08.2026) badał GPT-5 na 6 językach ONZ. Aneks wskazuje na dużą przewagę angielskiego nad rosyjskim w trudniejszych zadaniach z długim kontekstem: Multi-QA 82,71 wobec 54,17, Cloze 52,89 wobec 25,34. To pojedynczy odczyt, jeszcze niezweryfikowany. ⚠️

Praca arXiv:2602.20065 bywa podawana jako dowód na tezę o polskim, ale polskiego nie bada. Jedynie cytuje OneRuler.

**Luka.** Nie znaleźliśmy żadnego badania z lat 2025–2026, które porównywałoby polski z angielskim przy długim kontekście na Claude 4.x/5, GPT-5.x czy Gemini 3. Nie znaleźliśmy też replikacji OneRuler.

---

## 3. Rozumowanie: czy język zmienia wynik?

### 3.1 Najnowsze modele na tych samych pytaniach: prawie parytet

**mmPISA-bench**, Sapenov i Savelka, arXiv:2606.07069 (06.2026). Zadania w stylu testów PISA w 43 językach: 25 pytań na język, każde uruchomione 5 razy, czyli 125 odpowiedzi na komórkę. Bez testów istotności. ✅

| Język | Claude Haiku 4.5 (bez rozumowania) | Claude Opus 4.5 (wysoki wysiłek) | GPT-5.1 (bez rozumowania) | GPT-5.1 (wysoki wysiłek) |
|---|---|---|---|---|
| angielski | 90,4 | 100,0 | 76,8 | 96,8 |
| **polski** | 87,2 | 94,4 | **78,4** | 96,0 |
| czeski | 84,8 | 96,8 | 79,2 | 94,4 |
| słowacki | 88,0 | 96,0 | 74,4 | 95,2 |
| słoweński | 89,6 | 95,2 | 80,0 | 96,0 |
| chorwacki | 88,8 | 96,8 | 78,4 | 96,0 |
| serbski | 87,2 | 99,2 | 77,6 | 96,0 |
| bułgarski | 85,6 | 96,8 | 84,0 | 90,4 |
| rosyjski | 85,6 | 95,2 | 84,8 | 94,4 |

Polski ustępuje angielskiemu o 1–7 odpowiedzi na 125, a w jednej kolumnie go wyprzedza. To mieści się w granicach szumu. Kolumny Claude „bez rozumowania” i „wysoki wysiłek” dotyczą różnych modeli: Haiku i Opus.

**Mind the Gap… or Not?**, Peter, Vilar, Domhan, Malkin, Freitag (Google), arXiv:2511.05162 (11.2025, v2 06.2026). Autorzy ponownie przetłumaczyli błędne zadania matematyczne MGSM i poprawili sposób odczytywania odpowiedzi. Po tych poprawkach różnica między językami „w większości znika”. ✅

| Model | Różnica EN − RU przed poprawkami (pkt) | Różnica EN − RU po poprawkach (pkt) |
|---|---|---|
| Gemini 2.5 Pro | 2,4 | 0,0 |
| GPT-5 | 2,4 | 0,0 |
| Claude Sonnet 4.5 | 3,2 | −0,4 |
| Claude Haiku 4.5 | 4,0 | 0,4 |
| DeepSeek R1 | 2,4 | 0,4 |
| DeepSeek V3 | 4,8 | 2,0 |
| Gemma 3 27B | 6,0 | 3,2 |
| Gemma 3 12B | 4,4 | 2,8 |

Część zgłaszanej „przewagi angielskiego” bierze się więc z błędów tłumaczenia i oceny. W językach o małych zasobach duże różnice zostają: GPT-OSS-20B wciąż traci 18,4 pkt w suahili.

**PolyMath** (arXiv:2504.18428, NeurIPS 2025). Rosyjski wobec angielskiego na najnowszych modelach rozumujących: angielski prowadzi o 0,8–6,4 pkt w zależności od poziomu trudności (np. Qwen3-235B-Thinking na poziomie „high”: 66,4 wobec 60,0). Polskiego w tym zbiorze nie ma. ✅

### 3.2 Mniejsze i wyspecjalizowane modele: angielski nadal wyraźnie lepszy

**Polskie egzaminy lekarskie**, Grzybowski i in., arXiv:2412.00559 v2 (09.2025). Te same pytania egzaminacyjne po polsku i w oficjalnej wersji angielskiej, którą przetłumaczyli eksperci medyczni z Centrum Egzaminów Medycznych. Angielski wypada lepiej w **13 z 16 modeli** zarówno na LEK, jak i na LDEK. ✅

| Model | LEK PL | LEK EN |
|---|---|---|
| GPT-4o (2024-08) | **89,96** | 88,69 |
| Llama-3.1-70B | 80,94 | 82,60 |
| Qwen2.5-72B | 76,87 | 81,93 |
| Mistral-Large-2407 | 76,75 | 82,40 |
| GPT-4o-mini | 75,88 | 75,92 |
| Bielik-11B v2.2 | **62,36** | 56,98 |
| Qwen2.5-7B | 51,92 | 67,73 |
| Llama-3.1-8B | 51,25 | 64,69 |

Im większy model, tym mniejsza różnica. GPT-4o i polski Bielik osiągają wyższe wyniki po polsku.

**Bułgarskie MMLU**, Koeva i in., LREC 2026. Porównanie MMLU-BG z oryginalnym angielskim MMLU (wyniki dla kwantyzacji 8-bit, EN wobec BG): Gemma-3-27B 78,1 wobec 72,7; Qwen2.5-14B 75,0 wobec 64,2; BgGPT-9B 62,7 wobec 56,1. Różnice są mniejsze w modelach trenowanych na tekstach bułgarskich. ✅

**BgGPT 1.0** (arXiv:2412.10893). Dla 12 otwartych modeli średnia angielska przewyższa bułgarską o 8,5–22,4 pkt. ✅

### 3.3 Czy model powinien rozumować po angielsku?

- **Language Matters**, Tam i in., arXiv:2505.17407. Porównano rozumowanie wymuszone po angielsku z rozumowaniem w języku pytania na zbiorze MATH-500. Średnia dla rosyjskiego: 86,7 wobec 81,6 (+5,1). Prawie całą tę różnicę daje jeden model 8B (+19,0); w trzech większych modelach wynosi tylko 0,2–0,6 pkt. Języki o małych zasobach zyskują znacznie więcej, np. suahili +31,5. ✅
- **Crosslingual reasoning through test-time scaling** (arXiv:2505.05408). Rozumowanie w językach o dużych zasobach wypada w granicach 1–2 pkt od angielskiego. ☑️
- **Do multilingual LLMs think in English?** (arXiv:2502.15603). Analiza metodą logit lens pokazuje, że 50–70% reprezentacji pośrednich przechodzi przez angielski. Języków słowiańskich nie badano. ☑️

**Wniosek dla polskiego.** Nikt nie porównał rozumowania wymuszonego po angielsku z rozumowaniem po polsku. Dane dla rosyjskiego sugerują, że w dużych modelach efekt jest pomijalny.

### 3.4 Klasyfikacja tekstów (języki południowosłowiańskie)

Kuzman Pungeršek i in., arXiv:2511.07989 v2 (02.2026). Klasyfikacja tekstów parlamentarnych bez przykładów treningowych (zero-shot). Angielski wypada lepiej od średniej dla słoweńskiego, chorwackiego, serbskiego, bośniackiego i macedońskiego w każdym modelu, ale tylko nieznacznie. Różnica macro-F1 (sentyment / temat): GPT-5 0,02 / 0,05; GPT-4o 0,04 / 0,08; Gemini 2.5 Flash 0,04 / 0,08; Qwen 3 0,07 / 0,10. ✅

---

## 4. Agenci, narzędzia i wykonywanie instrukcji

| Źródło | Wynik | Status |
|---|---|---|
| **MAPS**, arXiv:2505.15935 v3 (02.2026): GAIA i inne benchmarki agentowe w 11 językach i po angielsku (bez polskiego) | GAIA: angielski **47,4%**, średnia dla pozostałych języków **35,8%** (−11,6 pkt). Rosyjski: GPT-o1 39,1 wobec 47,3 po angielsku; GPT-4o 32,7 wobec 40,1. Bezpieczeństwo agentów (benchmark ASB): skuteczność ataków 32,7% po angielsku i 47,3% w innych językach, więc prompty nieangielskie są też mniej bezpieczne | ✅ |
| **Marco-Bench-MIF**, arXiv:2507.11882: wykonywanie instrukcji, 25 modeli | Średnia: EN **76,2**, PL **58,6**, CS 64,0, RU 63,6, UK 58,5. Claude 3.5 Sonnet: EN 90,3 / PL 74,5. GPT-4o: EN 87,8 / PL 73,0 | ✅ |
| **Language Equality has a Price**, Hakimov i in., arXiv:2608.01395 (08.2026): wieloturowe gry dialogowe w 24 językach UE i kilku dodatkowych, 9 aktualnych modeli (clemscore 0–100) | Polski **poniżej** angielskiego w 7 z 9 modeli. GPT-5.4: PL 89,5 / EN 91,8. Opus-4.8: 82,3 / 84,4. Nemotron: 57,1 / 68,2. Qwen3.6: 45,9 / 55,6. Wyżej po polsku tylko Gemma4 (59,7 / 50,6) i Apertus (22,0 / 21,4). Średnia modeli: EN 61,9, PL 59,2, RU 59,4 | ✅ |
| **The Brittle Compass**, Harvan i in., arXiv:2611.01219 (RANLP-LowResNLP 2025): prompty słowackie wobec angielskich, 9 modeli × 3 metody | Słowackie prompty są nieco lepsze tylko w ekstrakcji lokalizacji (0,810 wobec 0,792, przedział ufności 0,003–0,033). W pozostałych zadaniach brak istotnej różnicy | ✅ |
| **MLCL**, arXiv:2601.05366: wywoływanie narzędzi w wielu językach (zh, hi, ig) | Typowy błąd: wartości parametrów zostają w języku użytkownika. Wcześniejsze tłumaczenie pomaga, ale żadna strategia nie dorównuje angielskiemu | ☑️ |

**Wniosek.** W zadaniach agentowych dowody wskazują jednoznacznie, że instrukcje po angielsku działają co najmniej tak samo dobrze. Żadne źródło nie pokazuje przewagi polskiego ani innego języka słowiańskiego.

---

## 5. Koszt: liczba tokenów w zależności od języka

| Źródło | Miara | Polski | Inne słowiańskie | Angielski | Status |
|---|---|---|---|---|---|
| Ovcharov, *The Tokenizer Tax*, arXiv:2605.24718 (05.2026); korpus SIB-200; 6 tokenizerów, w tym GPT-4o (o200k) | tokeny na słowo | **2,25** (1,88–2,60) | CS 2,28, SL 2,28, HR 2,31, BG 2,33, SK 2,45, UK 2,66 | **1,23** | ✅ |
| Petrov i in., NeurIPS 2023 (arXiv:2305.15425); korpus FLORES-200; tokenizer cl100k (GPT-4) | mnożnik względem angielskiego | **1,91×** | CS 2,11, SK 2,14, SL 1,88, RU 2,49, UK 3,00, BG 2,64 | 1,00 | ✅ |
| Raport Bielik v3, arXiv:2505.02550; preambuła Konstytucji RP, PL wobec EN | liczba tokenów | Mistral v0.1: 747 wobec 408 (1,83×); Qwen2.5: 625 wobec 373 (1,68×); polski tokenizer APT4: 375 wobec 631 | – | – | ✅ |

Nie ma opublikowanego pomiaru dla tokenizera Claude. Można go zmierzyć samodzielnie przez API Anthropic do liczenia tokenów na korpusie FLORES-200.

**Znaczenie w praktyce.** Ten sam `CLAUDE.md` napisany po polsku zajmuje ok. 1,7–1,9 razy więcej okna kontekstu i proporcjonalnie więcej kosztuje przy każdym wywołaniu.

---

## 6. Benchmarki polskie (kontekst)

- **PLCC** (kompetencje językowe i kulturowe w polszczyźnie, arXiv:2503.00995, 03.2025): Gemini-Exp-1206 83,00, Claude 3.5 Sonnet 82,67, GPT-4o 81,33, Bielik-2.3 11B 62,17. Nowszej tablicy wyników (HF `sdadas/plcc`) nie udało się odczytać. ☑️
- **Raport z rozumowania Bielika** (arXiv:2603.10640, 03.2026), 111 polskich zagadek logicznych: Gemini-3-pro-preview 87%, o3 87%, Gemini-2.5-pro 84%, Bielik-R 56%. ✅
- **MiniCzechBenchmark** (NeurIPS 2025): według abstraktu różnica między angielskim a czeskim wynosi 10–30%. Wyniki poszczególnych modeli są niedostępne. ⚠️
- Te benchmarki są wyłącznie po polsku (lub wyłącznie po czesku), więc same nie odpowiadają na pytanie „PL czy EN”.

---

## 7. Podsumowanie dowodów

| Obszar | Polski / słowiańskie wobec angielskiego | Siła dowodów |
|---|---|---|
| Wyszukiwanie w długim kontekście (NIAH) | Polski nieco **wyżej** (88 wobec 83,9); modele z 2025, zadanie syntetyczne, inne książki dla każdego języka, bez testów istotności | słaba, jedno badanie |
| Długi kontekst ze sprzecznymi informacjami | Rosyjski **niżej**, bo modele wolą źródło angielskie | jedno badanie z 2026 |
| Rozumowanie, najnowsze modele | **Prawie parytet** (różnica 1–7 odpowiedzi na 125; w MGSM po poprawkach ≈ 0) | umiarkowana |
| Rozumowanie, małe i średnie modele | Angielski **lepszy** (do 18 pkt na polskich egzaminach lekarskich) | umiarkowana do silnej |
| Wykonywanie instrukcji | Angielski **lepszy** (średnio PL 58,6 wobec EN 76,2) | umiarkowana |
| Interakcja wieloturowa, najnowsze modele z 2026 | Polski nieco **niżej** (−2,3 pkt dla GPT-5.4, −2,1 dla Opus-4.8) | umiarkowana, jedno badanie z 2026 |
| Zadania agentowe | Angielski **lepszy** (GAIA −11,6 pkt w innych językach); prompty nieangielskie mniej bezpieczne | umiarkowana (brak danych dla polskiego) |
| Koszt w tokenach | Polski zajmuje **1,7–1,9 razy więcej** tokenów | silna |

**Czy język wpływa na rozumowanie agenta?** W najnowszych modelach z lat 2025–2026 na samo rozumowanie wpływa w niewielkim stopniu. Wyraźnie wpływa natomiast na wykonywanie instrukcji, wywoływanie narzędzi i niezawodność agentów, gdzie angielskie instrukcje nadal są lepsze. Poza jednym syntetycznym benchmarkiem wyszukiwania polski nigdzie nie ma powtarzalnej przewagi.

---

## 8. Otwarte luki

- Wyniki OneRuler dla poszczególnych języków i modeli są tylko na wykresach; nie opublikowano plików z wynikami.
- Brak badań z 2026 porównujących polski z angielskim przy długim kontekście i w zadaniach agentowych na Claude 4.x/5, GPT-5.x i Gemini 3.
- Brak wypowiedzi autorów OneRuler w źródle pierwotnym; są tylko wywiady prasowe.
- Brak opublikowanego pomiaru kosztu polskiego w tokenizerze Claude.
- Wyniki BenchMAX dla czeskiego, serbskiego i rosyjskiego są tylko na wykresach.

## Źródła

Pełna lista z identyfikatorami S1–S25 znajduje się w wersji angielskiej: [report.en.md](report.en.md#sources). Najważniejsze:

- OneRuler: https://arxiv.org/abs/2503.01996
- mmPISA-bench: https://arxiv.org/abs/2606.07069
- Mind the Gap… or Not?: https://arxiv.org/abs/2511.05162
- Polskie egzaminy lekarskie (Grzybowski i in.): https://arxiv.org/abs/2412.00559
- Language Equality has a Price: https://arxiv.org/abs/2608.01395
- Language Bias under Conflicting Information: https://arxiv.org/abs/2604.07123
- MAPS: https://arxiv.org/abs/2505.15935
- Marco-Bench-MIF: https://arxiv.org/abs/2507.11882
- The Tokenizer Tax: https://arxiv.org/abs/2605.24718
- Petrov i in.: https://arxiv.org/abs/2305.15425
- Bułgarskie MMLU (LREC 2026): https://aclanthology.org/2026.lrec-1.366/
- Prasa (tylko jako ślady): Nauka w Polsce / PAP, 10.11.2025; Science in Poland, 27.11.2025; Spider's Web, 12.11.2025
