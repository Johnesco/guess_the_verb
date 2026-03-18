# Guess the Verb — Research Findings

A systematic study of parser verb and noun challenges in interactive fiction. This game serves as a controlled laboratory where each room tests specific categories of guess-the-verb failure.

## Theoretical Framework

See [Issue #29](https://github.com/Johnesco/ifhub/issues/29) for the full layered defense model. Summary:

| Layer | Mechanism | Handles |
|-------|-----------|---------|
| **0: Nouns** | Scenery objects + `Understand` aliases | "Can't see any such thing" |
| **1: Grammar** | `Understand the command "X" as "Y"` | Missing verb synonyms |
| **2: Mistakes** | `Understand "X" as a mistake (...)` | Structurally incompatible commands |
| **3: Custom Actions** | New action + Check/Carry out | Commands needing new game logic |
| **4: Parser Errors** | `printing a parser error` activity | Everything else (safety net) |

**Principle:** solve at the lowest layer possible.

## Per-Room Analysis

### Room 1: Front Porch — "Look Under" and "Ring"

**What it tests:** Physical interaction verbs that don't map to standard Inform 7 actions.

**Key objects:**
- Woven doormat (scenery) — key hidden underneath
- Brass doorbell (scenery) — push/ring interaction
- Front door (locked door) — unlock with key

**Verb challenges:**

| Player tries | What happens without mitigation | Mitigation applied |
|---|---|---|
| `lift mat` | Takes mat (wrong intent) | Layer 1: "lift" → "take"; Instead of taking mat → look under |
| `flip mat` | "Not a verb" | Layer 1: "flip" → "examine" (template) |
| `check under mat` | "Not a verb" for "check" | Layer 1: "check" → "examine" (standard) |
| `look under mat` | Works (standard action) | None needed |
| `ring doorbell` | "Not a verb" | Layer 3: Custom "ringing" action |
| `press bell` | "push" handles it | None needed (Layer 0: "bell" alias) |
| `knock on door` | "Not a verb" | Layer 3: Custom "knocking on" action |

**Noun challenges:**
- "mat" / "rug" / "doormat" — all aliased to woven doormat
- "bell" / "button" / "buzzer" — all aliased to brass doorbell
- "porch" / "boards" / "railing" — scenery for the porch structure

**Findings:**
- `LOOK UNDER` is a standard I7 action but rarely taught to new players
- Players who type "lift mat" or "take mat" have the right physical intent — redirecting to look-under feels natural
- "ring" is a verb that exists in English but not in I7 standard grammar — custom action required
- The doorbell tests PUSH (standard) vs RING (custom) vs PRESS (synonym for push)

---

### Room 2: Hallway — "Search" and "Climb"

**What it tests:** Container-like interactions with non-containers (coat pockets) and directional movement vocabulary.

**Key objects:**
- Old overcoat (scenery, not takeable) — matchbook hidden in pockets
- Coat rack (scenery) — redirects to coat
- Narrow staircase (scenery) — climb redirects to GO UP

**Verb challenges:**

| Player tries | What happens without mitigation | Mitigation applied |
|---|---|---|
| `search coat` | Works (standard) | None needed |
| `rummage coat` | "Not a verb" | Layer 1: "rummage" → "search" |
| `check pockets` | "check" → examine, "pockets" → coat | Layer 0: "pockets" alias on coat |
| `climb stairs` | Standard climbing action | Instead: try going up |
| `go upstairs` | "Can't see any such thing" (no "upstairs" direction) | Layer 1: "upstairs" as direction UP |
| `ascend` | "Not a verb" | Not handled yet — candidate for template |

**Noun challenges:**
- "pockets" / "pocket" — aliased to old overcoat (conceptual containment without a container object)
- "stairs" / "staircase" / "steps" / "stair" — aliased to narrow staircase
- "floor" / "floorboards" — scenery to prevent "can't see" on mentioned nouns

**Findings:**
- Overcoat demonstrates the "noun problem" — pockets are a part of an object, not a separate thing. Aliasing "pockets" to the coat makes `search pockets` → `search coat` → find matchbook. This is a common I7 pattern.
- Climbing something that isn't a direction requires an Instead rule to redirect. The staircase is a thing, not a direction.
- "upstairs" as a direction synonym is clean and reusable across projects.
- The coat rack → overcoat search redirect handles players who interact with the container (rack) instead of the contained (coat).

---

### Room 3: Study — "Light/Kindle", "Move/Look Behind", "Combination"

**What it tests:** Fire-starting verbs, discovering hidden objects behind scenery, knowledge-gated puzzles.

**Key objects:**
- Heavy desk (openable container) — winding key inside
- Oil painting (scenery) — hides wall safe behind it
- Wall safe (locked container, scenery until revealed) — needs combination
- Stone fireplace (scenery) — light to reveal combination on hearthstone
- Hearthstone (scenery) — shows "7-3-9" when fire is lit

**Verb challenges:**

| Player tries | What happens without mitigation | Mitigation applied |
|---|---|---|
| `light fireplace` | Maps to "switching on" (wrong) | Instead of switching on → try burning |
| `kindle fireplace` | "Not a verb" | Layer 1: "kindle" → burning |
| `ignite fireplace` | "Not a verb" | Layer 1: "ignite" → burning |
| `start fire` | "Not a verb" for "start" | Layer 1: "start" → burning |
| `burn matchbook` | Standard burning, but needs redirect | Instead: if in Study, try burning fireplace |
| `look behind painting` | "Not a verb phrase" | Layer 3: Custom "looking behind" action |
| `move painting` | Standard "push" (works!) | None needed |
| `slide painting` | "Not a verb" | Not handled — could add synonym |
| `open safe` | Works, but knowledge-gated | Instead: auto-dials if combo known |
| `dial 7-3-9` | "Not a verb" | Not handled — parser limit |

**Noun challenges:**
- "fire" / "fireplace" / "hearth" / "grate" / "logs" / "chimney" — all aliased to stone fireplace
- "hearth stone" / "soot" — aliased to hearthstone (separate from fireplace)
- "painting" / "portrait" / "picture" / "frame" — aliased to oil painting
- "safe" / "iron safe" / "combination" / "dial" — aliased to wall safe

**Findings:**
- The `light` → `switching on` ambiguity is a **major gotcha**. In I7 standard rules, "light X" tries "switching on" first for all things, not just devices. Must add `Instead of switching on [non-device]: try burning`.
- "look behind" requires a custom action — it's not in the I7 standard library despite being very natural English.
- Knowledge-gated puzzles (know the combination → auto-open) work cleanly with truth state variables. No need to implement a number-entry system.
- The Before rule blocking wall safe interaction until painting is moved is clean and prevents premature discovery.
- "burn matchbook" needs context-sensitive redirection — in the Study it should try burning the fireplace, elsewhere it should fail gracefully.

---

### Room 4: Kitchen — Breather Room

**What it tests:** Minimal interaction — atmospheric pacing between puzzle rooms. Tests "turn" verb on faucet and "read" on recipe card.

**Key objects:**
- Ceramic sink (scenery) — faucet can be turned
- Recipe card (scenery) — flavor text, ties narrative to garden
- Copper pots (scenery) — decoration
- Stone counters (scenery) — prevents "can't see" errors

**Verb challenges:**

| Player tries | What happens without mitigation | Mitigation applied |
|---|---|---|
| `turn faucet` | Standard turning action | Instead: flavor text |
| `read recipe` | "read" → examine (standard) | None needed |
| `wash hands` | "Not a verb" | Not handled — atmospheric only |
| `cook` | "Not a verb" | Not handled — could add as mistake |

**Findings:**
- Even breather rooms need scenery objects for every mentioned noun. "copper pots" in the description requires a scenery object.
- "turn" is a standard I7 action that works on scenery — good for faucets, dials, knobs.
- The recipe card provides narrative justification for the garden without being a puzzle item.

---

### Room 5: Garden — "Dig" and Tool Dependency

**What it tests:** Custom actions requiring tools, bare-verb handling (no noun), tool discovery.

**Key objects:**
- Flower bed (scenery) — dig to find mechanism
- Garden trowel (takeable) — required for digging
- Garden shed (scenery) — atmospheric
- Mechanism (nowhere → Garden after digging) — music box part

**Verb challenges:**

| Player tries | What happens without mitigation | Mitigation applied |
|---|---|---|
| `dig` | "Not a verb" | Layer 3: Custom "digging-here" (no noun) → redirects to flower bed if in Garden |
| `dig flower bed` | "Not a verb" | Layer 3: Custom "digging" action |
| `dig dirt` / `dig earth` / `dig ground` | "Not a verb" for "dig" | Layer 0: aliases on flower bed + Layer 3 |
| `excavate` | "Not a verb" | Layer 1: "excavate" → digging |
| `dig here` | "Not a verb" | Layer 3: "dig here" → digging-here |
| `dig with trowel` | Tricky — "with" implies two-noun | Not fully handled — could add grammar |
| `use trowel` | USE handler redirects | Layer 3: USE handler |
| `use trowel on flower bed` | USE handler | Layer 3: generic-using it with |

**Findings:**
- **Bare verbs** ("dig" with no noun) need a separate action applying to nothing, with location-based redirection. This is a common pattern for context-sensitive verbs.
- Tool dependency is cleanly handled at the Check level — "you'd need a tool" teaches the player what to find.
- The flower bed aliases ("soil", "dirt", "earth", "ground") are critical — room description says "earth looks soft" which prompts "dig earth".
- The "nowhere → in Garden" pattern for hidden objects is standard I7 and works well with the scoring system.

---

### Room 6: Attic — Assembly and Winding

**What it tests:** Multi-object assembly, custom "wind" action, mechanical puzzle resolution, indirect unlocking.

**Key objects:**
- Dusty shelf (supporter, scenery) — music box sits on it
- Old music box (openable container on shelf) — needs mechanism + spring, then winding
- Steamer trunk (locked container) — mechanically connected to music box
- Family locket (in trunk) — end-game prize

**Verb challenges:**

| Player tries | What happens without mitigation | Mitigation applied |
|---|---|---|
| `put mechanism in music box` | Standard inserting (works) | None needed |
| `attach mechanism to music box` | "Not a verb" for "attach" | Layer 1: "attach X to Y" → inserting |
| `install spring in music box` | "Not a verb" for "install" | Layer 1: "install X in Y" → inserting |
| `combine spring with music box` | "Not a verb" for "combine" | Layer 3: Custom combining action → inserting |
| `fix music box` | "Not a verb" for "fix" | Layer 3: Custom repairing → status feedback |
| `repair music box` | "Not a verb" | Layer 3: "repair" → repairing |
| `assemble music box` | "Not a verb" | Layer 3: "assemble" → repairing |
| `wind music box` | "Not a verb" | Layer 3: Custom winding action |
| `wind up music box` | "Not a verb" | Layer 3: "wind up" grammar |
| `crank music box` | "Not a verb" | Layer 3: "crank" → winding |
| `wind music box with key` | Two-noun variant | Layer 3: winding it with → try winding |
| `use key on music box` | USE handler | Layer 3: generic-using it with (lockable check) |
| `unlock trunk` | "What with?" | Instead: "no keyhole, mechanically connected" |

**Findings:**
- Assembly puzzles require **three layers of support**: (1) standard PUT IN works, (2) synonym verbs redirect to inserting, (3) "fix/repair/assemble" give state-aware feedback about what's missing.
- The "winding" custom action is entirely new — I7 has no standard "wind" verb. It requires explicit grammar for both one-noun and two-noun forms.
- The `winding it with` → `try winding` redirect is important — players naturally type "wind X with Y" but the Check logic only needs the key to be carried, not passed as a parameter.
- Indirect unlocking (music box → trunk) is a clean mechanical puzzle. The Instead rule for `unlocking trunk with` provides a hint about the mechanism.
- The music box's dynamic description (0 parts → 1 part → 2 parts → ready) gives clear assembly progress feedback.

---

## Cross-Cutting Findings

### Layer 0 (Nouns) is the Hidden Killer

Every room description mentions nouns that must be parseable objects. Without scenery objects and aliases:
- "porch", "boards", "railing" → "can't see any such thing"
- "wallpaper", "floor", "floorboards" → "can't see any such thing"
- "pockets" → "can't see any such thing"
- "soot", "hearth stone" → "can't see any such thing"

**Rule of thumb:** if it appears in a room description, it needs an object.

#### Systematic Noun Audit

A full audit of this 6-room, 32-object game found **~170 noun phrases** in player-visible text against **~130 Understand aliases**. The initial gap was **~30 uncovered nouns** — nearly 1 in 5. After fixes, the game has **~150 aliases** with zero "can't see" errors on reasonable input.

**Noun coupling categories** — every mentioned noun falls into one of these:

| Category | Strategy | Example |
|---|---|---|
| **Primary nouns** | Object exists, name matches | "heavy desk" → heavy desk object |
| **Synonym nouns** | Alias on existing object | "pots" → copper pots |
| **Part-of nouns** | Alias on parent object | "pockets" → overcoat, "lid" → music box, "handles" → desk |
| **Collocated nouns** | Alias on nearby object in same scope | "hooks" → copper pots (Kitchen), "cobwebs" → shed |
| **Atmospheric nouns** | Alias on room's catch-all scenery | "dust" → sloping eaves, "wall" → wallpaper/paneling/eaves |
| **New scenery** | New object needed (noun has no natural parent) | "porch" → sagging porch scenery |

The most common gap is **part-of nouns** — descriptions that mention component parts of objects (keyholes, handles, lids, locks, fittings) that aren't aliased because the author thinks of them as part of the description, not as interactive targets. The second most common is **collocated nouns** — a detail in one object's description (e.g., "iron hooks" in the copper pots description) that isn't aliased on that object.

**The discipline:** after writing any description, extract every concrete noun and verify it resolves to an in-scope object. The question isn't "would a player examine this?" but "could they?" If the answer is yes and the parser says "can't see," that's a bug.

### The "light" Ambiguity

`light X` maps to BOTH `switching on` AND `burning` in the Standard Rules. For non-device things, the parser tries `switching on` first and gives an unhelpful error. Every game with fire/light sources needs:

```inform7
Instead of switching on [fire-thing]: try burning [fire-thing].
```

This is a framework-level finding that should be documented in `reference/verb-help.md`.

### Bare Verbs Need Special Handling

Verbs like "dig" (no noun) are natural but require a separate action applying to nothing, with location-based context:

```inform7
Digging-here is an action applying to nothing.
Understand "dig" as digging-here.
Carry out digging-here:
    if in Garden: try digging the flower bed;
    otherwise: say "Nothing to dig here."
```

### Assembly Verbs are a Category

Players express assembly intent with many verbs: put, attach, install, combine, fix, repair, assemble, connect, add. The first three can redirect to `inserting it into`. The rest need a custom "repairing" action that gives state-aware feedback.

### Recommended Template Additions

Based on this game's findings, these should be promoted to the shared template (`tools/verb-help-template.ni`):

| Synonym | Maps to | Rationale |
|---------|---------|-----------|
| `look around` | looking | Universal — first thing many players type |
| `help me` | requesting help | Common variant of HELP |
| `browse` | examine | Natural for books/shelves |
| `rummage` | search | Natural for containers/pockets |
| `upstairs` / `downstairs` | up / down | Direction synonyms |

### Disambiguation is a Hidden Hazard

When two objects share a word in their printed name or Understand aliases, the parser asks "Which do you mean?" — breaking walkthrough automation and frustrating players. Example from this game:

- "coat rack" and "old overcoat" — both contain "coat"
- `search coat` → "Which do you mean, the coat rack or the old overcoat?"

**Mitigation:** `Does the player mean doing something to the old overcoat: it is likely.` This tells the parser to prefer the overcoat when ambiguous. Alternatively, rename objects to avoid shared words.

**Rule of thumb:** after adding Understand aliases, check every word against all other object names in the same room.

### Parser Redirect Clarification Messages

When a custom action silently redirects to a different standard action, the player never learns what the parser actually did. For **semantic redirects** — where the concept changes (ring→push, climb stairs→go up, look behind→push) — we add a parenthesized clarification message using I7's `[command clarification break]` formatting, matching the existing "(first taking X)" convention:

```
>ring doorbell
(pressing the brass doorbell)
You press the doorbell. A faint chime echoes inside the house, unanswered.
```

**What gets a message:**

| Redirect | Clarification | Rationale |
|---|---|---|
| `ring doorbell` → push | `(pressing the brass doorbell)` | Different concept |
| `climb stairs` → go up | `(going up)` | Object→direction |
| `look behind painting` → push | `(moving the oil painting)` | Different concept |
| `dig` (bare) → dig flower bed | `(digging the flower bed)` | Implicit noun |
| `light fireplace` → burn | `(lighting the fireplace)` | switching on ≠ burning |
| `burn matchbook` → burn fireplace | `(lighting the fireplace)` | Different target |
| `search rack` → search overcoat | `(searching the overcoat)` | Different target |

**What does NOT get a message:**

| Redirect | Why silent |
|---|---|
| `grab` → take, `inspect` → examine | Pure synonyms — same concept, different word |
| `rummage` → search, `browse` → examine | Close enough semantically |
| `kindle`/`ignite` → burning | Near-synonyms for the same concept |
| `attach`/`install` → inserting | Assembly synonyms, same intent |
| `wind X with Y` → wind X | Internal simplification |
| `fix music box` → status feedback | Already gives its own feedback |

**Design principle:** clarification messages teach the player the canonical verb for future interactions. They should feel like helpful parser feedback, not compiler output. Use `(action-oriented phrase)[command clarification break]` — NOT `(understood as: pushing)`.

---

### Known Parser Limits (Cannot Fix in I7)

1. **"dial 7-3-9"** — entering numbers as verb arguments requires custom token definitions
2. **"slide painting"** — "slide" is not a standard verb and adding it as a push synonym would affect all objects
3. **"dig with trowel"** — bare verb + "with" preposition + tool but no direct object is hard to parse
4. **Conversational prefixes** — "please open door", "can I take key" — first word parsed as verb
