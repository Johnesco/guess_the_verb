# Beyond "Understand": A Layered Defense Against Guess-the-Verb

*What I learned building a 6-room Inform 7 game whose sole purpose is to break the parser.*

---

## The Problem Everyone Knows About

If you've played parser interactive fiction, you've hit this wall:

```
>ring doorbell
That's not a verb I recognise.

>press doorbell
You press the doorbell. A faint chime echoes inside the house, unanswered.
```

The player knew what to do. They used a perfectly reasonable English word. The game rejected it anyway. This is the **guess-the-verb problem** — and it's been the single biggest accessibility barrier in parser IF for forty years.

The standard advice is: add more `Understand` lines. Map "ring" to "push", "grab" to "take", "inspect" to "examine". Pile on synonyms until nothing falls through. And yes, that helps. But after building a game designed to stress-test every category of parser failure, I found that brute-force synonyms only address one of at least five distinct layers of the problem — and not even the most dangerous one.

## The Laboratory

I built [Guess the Verb](http://127.0.0.1:8000/guess_the_verb/play.html) as a controlled experiment. Six rooms, ten scoring puzzles, each room testing a different category of parser failure:

- **Front Porch**: physical interaction verbs (ring, knock, look under)
- **Hallway**: container-like interactions with non-containers (search pockets) and movement vocabulary (climb stairs)
- **Study**: fire-starting verbs, hidden objects behind scenery, knowledge-gated locks
- **Kitchen**: breather room (even breather rooms can break)
- **Garden**: custom actions with tool dependencies, bare verbs (just "dig" with no noun)
- **Attic**: multi-object assembly, winding, indirect unlocking

I played through systematically, typing every wrong thing I could think of, and documented what broke and why. Here's the framework that emerged.

## Five Layers of Defense

The key insight: guess-the-verb is not one problem. It's at least five, and they need different solutions.

### Layer 0: The Noun Problem (The Hidden Killer)

Before we even get to verbs — if your room description mentions "copper pots hanging from hooks," the player will try `examine pots`. Without a scenery object:

```
>examine pots
You can't see any such thing.
```

The game just told the player that something in its own description doesn't exist. This is worse than a verb failure because it feels like a bug, not a vocabulary mismatch.

**The fix:** every noun mentioned in a room description needs to be a parseable object, even if it does nothing. Scenery objects with Understand aliases are cheap:

```inform7
The copper pots are scenery in the Kitchen.
The description is "Tarnished copper pots hanging from iron hooks."
Understand "pots" and "pans" and "pot" and "pan" as the copper pots.
```

But it goes deeper than that. When I did a systematic audit — extracting every noun from every player-visible string and cross-referencing against every parseable object — I found **~170 noun phrases** against **~130 aliases** in a 6-room game. Nearly 1 in 5 nouns had no parser coverage. And the gaps weren't random. They fell into a taxonomy:

| Category | Example | Why it's missed |
|---|---|---|
| **Part-of nouns** | "keyhole" on a door, "lid" on a music box, "handles" on a desk | Author thinks of them as description, not interactive targets |
| **Collocated nouns** | "iron hooks" in the copper pots description | Detail in one object's text, never aliased to that object |
| **Atmospheric nouns** | "dust" in the attic, "cobwebs" in the shed | Flavor text the author didn't expect anyone to examine |
| **Cross-room collisions** | "hooks" in Kitchen vs. "hooks" aliased to coat rack in Hallway | Alias exists but in wrong scope — parser says "can't see" in the room where it matters |

The worst offender in my game: the Kitchen description says "Copper pots hang from hooks above." The word "hooks" was only aliased to the coat rack in a different room. A player in the Kitchen typing `examine hooks` gets "can't see any such thing" — despite the room description literally mentioning hooks.

**The discipline:** after writing any description, extract every concrete noun and ask: "if a player types `examine [this noun]`, will the parser find something?" If the answer is no, either alias it to an existing object or create scenery. The question isn't "would a player examine this?" but "could they?"

This layer surprised me the most. I expected verb failures to dominate. Instead, roughly half the frustrating moments in my playtesting were "can't see any such thing" — the noun layer, not the verb layer.

### Layer 1: Grammar Synonyms (The Standard Answer)

This is what people mean when they say "add more Understand lines." It maps an unknown verb to a known one:

```inform7
Understand the command "grab" as "take".
Understand the command "inspect" as "examine".
Understand the command "kindle" as "burn".
```

This works beautifully for **pure synonyms** — words that mean exactly the same thing as the standard verb. "Grab" is "take." "Inspect" is "examine." No information is lost.

I catalogued about 40 common synonyms across 11 categories (examination, taking, combat, looking, going, opening, dropping, putting, pushing, pulling, eating). That covers a huge percentage of real-world verb failures. But it doesn't cover everything, and the failures it misses are qualitatively different.

### Layer 2: Mistake Patterns

Some commands are structurally incompatible with what the parser expects. The player's intent is clear, but the grammar doesn't fit any action template:

```inform7
Understand "talk to [someone]" as a mistake
    ("To talk, try ASK person ABOUT topic.").
```

This catches the input, explains why it didn't work, and teaches the correct form — all without creating a new action. It's the right tool when the player's phrasing can't be mechanically translated to a valid command.

### Layer 3: Custom Actions (Where It Gets Interesting)

Here's where pure synonyms fail. Some verbs aren't synonyms at all — they're **conceptually different actions** that happen to produce the same game-world result:

- "ring doorbell" → The player means "ring." The game needs to do "push." These are not the same concept.
- "climb stairs" → The player means "climb this object." The game needs to do "go up." An object isn't a direction.
- "look behind painting" → The player means "check what's behind it." The game needs to do "push" to move it aside.
- "dig" (with no noun) → The player means "dig right here." The game needs to figure out *what* to dig.

You can't solve these with `Understand the command "ring" as "push"` because that would make "ring" mean "push" everywhere — `ring bell` would work but so would `ring painting`, which makes no sense.

Instead, you need a custom action that contains the redirect logic:

```inform7
Ringing is an action applying to one thing.
Understand "ring [something]" as ringing.

Carry out ringing:
    if the noun is the brass doorbell:
        say "(pressing [the noun])[command clarification break]";
        try pushing the brass doorbell;
    otherwise:
        say "You can't ring [the noun]."
```

That `(pressing the brass doorbell)` line is new — it's a **clarification message**, borrowed from I7's built-in "(first taking X)" convention. It tells the player what the parser actually did, so they learn the canonical verb for next time. I added these only for semantic redirects (where the concept changes), not for pure synonyms (where the concept is the same).

The bare-verb pattern is its own subproblem. When a player types just `dig` in a garden, it's obvious what they mean. But the parser wants a noun. This requires a second action:

```inform7
Digging-here is an action applying to nothing.
Understand "dig" as digging-here.

Carry out digging-here:
    if the player is in the Garden:
        say "(digging the flower bed)[command clarification break]";
        try digging the flower bed;
    otherwise:
        say "There's nothing to dig here."
```

### Layer 4: Better Error Messages (The Safety Net)

After all the above, some inputs will still fail. The default Inform 7 error messages are cryptic:

```
>flurble
That's not a verb I recognise.

>examine dragon
You can't see any such thing.
```

These can be replaced with messages that teach the player how to play:

```inform7
Rule for printing a parser error when the latest parser error is
    the not a verb I recognise error:
    say "I don't know that command. Type VERBS for a list,
        or try simpler phrasing like VERB NOUN."
```

This is a safety net, not a solution. If a player hits Layer 4, all the earlier layers failed to catch their intent. But the error message can at least point them toward recovery instead of just saying "no."

## The Gotchas I Didn't Expect

### "light" Is Ambiguous at the Engine Level

In Inform 7, `light X` maps to both `switching on` and `burning`. For non-device things, the parser may try "switching on" first and produce:

```
>light fireplace
That's not something you can switch on.
```

Every game with fire needs an explicit redirect:

```inform7
Instead of switching on the stone fireplace:
    say "(lighting the fireplace)[command clarification break]";
    try burning the stone fireplace.
```

This is a framework-level bug, not a game-level one. It's in the Standard Rules.

### Disambiguation Breaks Automation

When two objects share a word — like "coat rack" and "old overcoat" both containing "coat" — the parser asks "Which do you mean?" This breaks walkthrough automation and frustrates players who thought they were being specific.

Fix with `Does the player mean`:

```inform7
Does the player mean doing something to the old overcoat: it is likely.
```

### Pockets Aren't Things

A coat has pockets. A player types `search pockets`. But pockets aren't a separate object in the world model — they're a conceptual part of the coat. The solution is to alias "pockets" to the coat:

```inform7
Understand "pockets" and "pocket" as the old overcoat.
```

Now `search pockets` → `search overcoat` → find matchbook. The player never knows they interacted with "the old overcoat" instead of "the pockets."

### Assembly Is Three Problems

When a player needs to put a mechanism into a music box, they might type:

1. `put mechanism in music box` (standard — works)
2. `attach mechanism to music box` (synonym — needs Layer 1 redirect)
3. `fix music box` (different intent entirely — needs state-aware feedback)

Category 3 can't be a synonym. "Fix" doesn't mean "insert." It means "I know this thing is broken, help me figure out what to do." The response needs to be aware of the current state:

```inform7
Instead of repairing the old music box:
    if the mechanism is not in the old music box and the clock spring is not in the old music box:
        say "The music box needs its mechanism and spring. Try putting them inside.";
    otherwise if the mechanism is not in the old music box:
        say "The music box still needs its mechanism.";
    otherwise if the clock spring is not in the old music box:
        say "The music box still needs its spring.";
    otherwise:
        say "The parts are in place. Try winding it."
```

This is where the "just add synonyms" advice completely breaks down. State-aware feedback is a game design problem, not a grammar problem.

## So What Actually Works?

After cataloguing every failure mode across six rooms and ~70 test inputs, here's my hierarchy:

1. **Make every described noun parseable.** This catches more frustration than any verb work. Cheap, mechanical, high impact.

2. **Add ~40 common verb synonyms from a template.** One-time investment, covers the vast majority of vocabulary mismatches. I've published [my template](http://127.0.0.1:8000/guess_the_verb/source.html) with the full list.

3. **Write custom actions for semantic redirects.** Ring, climb, look behind, dig — these need real code, not synonym tables. Add clarification messages so players learn the canonical verb.

4. **Handle bare verbs with location context.** "dig" in a garden should just work. Make the game smart enough to infer the obvious noun.

5. **Replace default error messages.** When everything else fails, teach the player how to recover instead of just saying "no."

6. **Add a VERBS command.** Let the player see what's available. This is the simplest thing you can do and it's wild that it isn't standard.

7. **Accept the limits.** "dial 7-3-9" and "please open the door" will never work in a fixed-grammar parser. Design your puzzles so they don't require verbs the parser can't handle, or provide alternative phrasings in your descriptions.

## The Deeper Question

All of this is mitigation. The fundamental tension is: **a parser IF game is a natural language interface backed by a fixed grammar table.** Players expect English. The parser speaks a subset of English that happens to look like the full thing.

Is there a better approach than patch-by-patch synonym mapping? Maybe. Some directions I'm curious about:

- **Fuzzy matching / Levenshtein distance** — "examin" → "examine" — but I7's parser operates at the grammar table level (I6 compiled), so this would require engine-level changes, not I7 source
- **Pre-parser normalization** — a layer that rewrites input before the parser sees it — Dialog (another IF language) does something like this
- **Intent classification** — treat the parser as an NLU system that classifies player intent into action categories, rather than pattern-matching exact grammar — this is how modern chatbots work, but it's the opposite of how I7 works
- **Description-driven hinting** — if the description says "a brass doorbell is set beside the frame," algorithmically suggest PUSH DOORBELL when the player fails with RING DOORBELL — the information is right there in the text

For now, the five-layer model handles the problem well enough that my 6-room game accepts essentially every reasonable English phrasing I could think of. The approach is systematic, portable across projects, and — critically — doesn't require engine modifications.

But I'd love to hear from other IF authors: what patterns have you found? What breaks that I haven't thought of? Is there a Layer 6?

---

*[Guess the Verb](http://127.0.0.1:8000/guess_the_verb/play.html) is playable in the browser. [Full source](http://127.0.0.1:8000/guess_the_verb/source.html) is available. Research findings are documented in [FINDINGS.md](https://github.com/Johnesco/guess-the-verb/blob/main/FINDINGS.md).*
