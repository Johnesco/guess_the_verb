"Guess the Verb" by "John Googol"

The story headline is "A Parser Puzzle Laboratory".
The story genre is "Puzzle".
The release number is 1.
The story creation year is 2026.
The story description is "Explore your grandmother's old house and find the family heirloom she left behind. Every room tests a different verb pattern."

Use American dialect.
Use scoring.
The maximum score is 10.

Part 1 - Configuration

Chapter 1 - Settings

When play begins:
	now the left hand status line is "[the player's surroundings]   Score: [score]/[turn count]";
	now the right hand status line is "".

After printing the banner text:
	say "Your grandmother[apostrophe]s letter said she left something for you in this old house.[paragraph break]Type HELP if you get stuck, or VERBS for a list of commands.[paragraph break]".

Chapter 2 - Score Ranks

Table of Rankings
score	ranking
0	"Newcomer"
3	"Explorer"
6	"Tinkerer"
10	"Heir"

Chapter 3 - Properties

A thing can be scored or unscored. A thing is usually unscored.

Chapter 4 - Test Commands

Test me with "look under mat / take iron key / unlock door with iron key / open door / east / search overcoat / east / open desk / take winding key / push painting / light fireplace / examine hearthstone / open safe / take spring / west / south / south / take trowel / dig flower bed / take mechanism / north / north / up / put mechanism in music box / put spring in music box / wind music box / take locket".

Test verbs with "verbs / help / help me".
Test synonyms with "grab iron key / inspect iron key / proceed east / gaze / peek / rummage overcoat / browse bookshelves / peer / shove painting / yank painting / kindle fireplace / fetch spring / head west / head south / head south / snag trowel / excavate flower bed / nab mechanism / head north / head north / head up / attach mechanism to music box / install spring in music box / crank music box / lift locket".
Test use with "use iron key / use iron key on door".
Test errors with "flurble / xyzzy / swim / examine dragon".
Test naive with "where am i / look around / examine the doormat / look under the mat / pick up the key / unlock the door with the key / open the door / go inside / look around / examine the overcoat / search the pockets / what am i carrying / head east / look around / open the desk / take the small key / examine the painting / move the painting / light the fireplace / examine the hearthstone / open the safe / take the spring / leave / go south / read the recipe card / head south / look around / grab the trowel / dig the flower bed / grab the gears / go back / go north / go upstairs / examine the music box / put the gears in the music box / put the spring in the music box / wind the music box / open the trunk / take the locket / look at the locket / score".

Part 2 - The House

Chapter 1 - Front Porch

The Front Porch is a room. "A sagging wooden porch wraps around the front of the house. A woven doormat lies before the front door. A tarnished brass doorbell is set beside the frame.[paragraph break]The front door leads inside to the east."

The front door is east of the Front Porch and west of the Hallway. The front door is a door. The front door is closed, openable, and locked. The iron key unlocks the front door. The description of the front door is "A heavy oak door with peeling green paint and an old-fashioned keyhole."
Understand "oak door" and "keyhole" and "paint" as the front door.

The woven doormat is scenery in the Front Porch. The description of the woven doormat is "A faded doormat reading [apostrophe]WELCOME[apostrophe]. One corner is curled up -- something glints underneath."
Understand "mat" and "rug" and "welcome mat" and "doormat" as the woven doormat.

The iron key is nowhere. The description of the iron key is "A heavy iron key, dark with age."
Understand "old key" and "heavy key" and "house key" as the iron key.

Instead of looking under the woven doormat:
	if the iron key is nowhere:
		now the iron key is in the Front Porch;
		say "You lift the corner of the doormat and find an iron key hidden underneath.";
		if the iron key is unscored:
			now the iron key is scored;
			increase the score by 1;
	otherwise:
		say "Nothing else under the mat."

Instead of searching the woven doormat:
	try looking under the woven doormat.

Instead of taking the woven doormat:
	try looking under the woven doormat.

The brass doorbell is scenery in the Front Porch. The description of the brass doorbell is "A tarnished brass button set into the door frame."
Understand "bell" and "button" and "buzzer" and "door bell" and "doorbell" and "door frame" as the brass doorbell.

Instead of pushing the brass doorbell:
	say "You press the doorbell. A faint chime echoes inside the house, unanswered."

Instead of pulling the brass doorbell:
	say "It[apostrophe]s a push button, not a pull cord. Try pressing it."

The sagging porch is scenery in the Front Porch. The description of the sagging porch is "Weathered boards that sag under your weight. The paint peeled away long ago."
Understand "porch" and "boards" and "railing" as the sagging porch.

Chapter 2 - Hallway

The Hallway is a room. "A dim hallway with faded wallpaper and creaking floorboards. A coat rack stands by the door with an old overcoat hanging from it.[paragraph break]Doors lead east to a study and south to the kitchen. A narrow staircase leads up."

The coat rack is scenery in the Hallway. The description of the coat rack is "A wooden coat rack, slightly tilted. An old overcoat hangs from one hook."
Understand "rack" and "hook" and "hooks" and "stand" as the coat rack.

The old overcoat is scenery in the Hallway. The description of the old overcoat is "A moth-eaten wool overcoat. The pockets look like they might hold something."
Understand "coat" and "jacket" and "overcoat" and "wool coat" and "dusty coat" as the old overcoat.
Understand "pockets" and "pocket" as the old overcoat.

Instead of taking the old overcoat:
	say "The coat is too moth-eaten to carry. But you could search the pockets."

Instead of wearing the old overcoat:
	say "The coat is too moth-eaten to wear. But you could search the pockets."

The matchbook is nowhere. The description of the matchbook is "A small book of matches from [apostrophe]The Golden Lantern.[apostrophe] A few matches remain."
Understand "matches" and "match" and "book of matches" as the matchbook.

Instead of searching the old overcoat:
	if the matchbook is nowhere:
		now the matchbook is carried by the player;
		say "You rummage through the coat pockets and find a matchbook.";
		if the matchbook is unscored:
			now the matchbook is scored;
			increase the score by 1;
	otherwise:
		say "The pockets are empty now."

Instead of searching the coat rack:
	say "(searching the overcoat)[command clarification break]";
	try searching the old overcoat.

Does the player mean doing something to the old overcoat: it is likely.

The narrow staircase is scenery in the Hallway. The description of the narrow staircase is "A wooden staircase with groaning steps. It leads up into shadows."
Understand "stairs" and "staircase" and "steps" and "stair" as the narrow staircase.

Instead of climbing the narrow staircase:
	say "(going up)[command clarification break]";
	try going up.

The faded wallpaper is scenery in the Hallway. The description of the faded wallpaper is "Yellowed wallpaper with a faded floral pattern, peeling at the seams."
Understand "wallpaper" and "wall" and "walls" and "paper" as the faded wallpaper.

The creaking floorboards are scenery in the Hallway. The description of the creaking floorboards is "Dark wooden floorboards that creak underfoot."
Understand "floor" and "floorboard" and "boards" and "floorboards" as the creaking floorboards.

Chapter 3 - Study

The Study is east of the Hallway. "A wood-paneled study with built-in bookshelves. A heavy desk sits in the center, its drawers shut. An oil painting of a woman hangs on the far wall. A stone fireplace squats in the corner, cold and dark.[paragraph break]The hallway is back to the west."

The study bookshelves are scenery in the Study. The description of the study bookshelves is "Floor-to-ceiling shelves packed with dusty volumes. Nothing stands out."
Understand "bookshelves" and "bookshelf" and "shelves" and "books" and "book" and "volumes" and "volume" as the study bookshelves.

The heavy desk is a closed openable container in the Study. It is fixed in place. The description of the heavy desk is "A mahogany desk with brass handles. The drawers are [if the heavy desk is open]open[otherwise]closed[end if]."
Understand "drawers" and "drawer" and "mahogany desk" and "handles" and "handle" and "brass handles" as the heavy desk.

The winding key is in the heavy desk. The description of the winding key is "A small key shaped like a butterfly, clearly meant for winding something delicate."
Understand "butterfly key" and "small key" and "delicate key" as the winding key.

After taking the winding key for the first time:
	if the winding key is unscored:
		now the winding key is scored;
		increase the score by 1.

The oil painting is scenery in the Study. The description of the oil painting is "A portrait of a stern woman in a high collar -- your grandmother, perhaps. The frame sits slightly askew on the wall."
Understand "painting" and "portrait" and "picture" and "frame" and "woman" and "grandmother" as the oil painting.

The wall safe is a closed openable locked container in the Study. It is fixed in place and scenery. The description of the wall safe is "[if the painting-moved is false]You don[apostrophe]t see any safe here.[otherwise]A small iron safe set into the wall. It has a three-dial combination lock."
Understand "safe" and "iron safe" and "combination" and "dial" and "dials" and "lock" and "combination lock" as the wall safe.

The painting-moved is a truth state that varies. The painting-moved is false.

Before doing anything to the wall safe when the painting-moved is false:
	say "You don[apostrophe]t see any safe here." instead.

Instead of pushing or pulling the oil painting:
	if the painting-moved is false:
		now the painting-moved is true;
		say "You slide the painting aside, revealing a small wall safe set into the wall.";
	otherwise:
		say "The painting is already moved. The wall safe is exposed."

Instead of looking under the oil painting:
	try pushing the oil painting.

Instead of turning the oil painting:
	try pushing the oil painting.

The stone fireplace is scenery in the Study. The description of the stone fireplace is "[if the fireplace-lit is true]A cheerful fire crackles in the grate, casting warm light across the room.[otherwise]A wide stone fireplace with old logs in the grate, ready to burn. The hearthstone is blackened with soot."
Understand "fireplace" and "hearth" and "grate" and "fire" and "logs" and "log" and "chimney" as the stone fireplace.

The hearthstone is scenery in the Study. The description of the hearthstone is "[if the fireplace-lit is true]In the firelight you can make out numbers scratched into the stone: 7-3-9.[otherwise]A broad flat stone at the base of the fireplace, blackened with soot. Hard to make out any detail."
Understand "hearth stone" and "soot" as the hearthstone.

The fireplace-lit is a truth state that varies. The fireplace-lit is false.

Instead of burning the stone fireplace:
	if the fireplace-lit is true:
		say "The fire is already crackling away.";
	otherwise if the player does not carry the matchbook:
		say "You[apostrophe]d need something to light it with.";
	otherwise:
		now the fireplace-lit is true;
		say "You strike a match and hold it to the logs. They catch quickly, filling the room with flickering warmth.[paragraph break]In the glow, you notice numbers scratched into the hearthstone: 7-3-9.";
		if the stone fireplace is unscored:
			now the stone fireplace is scored;
			increase the score by 1.

Instead of switching on the stone fireplace:
	say "(lighting the fireplace)[command clarification break]";
	try burning the stone fireplace.

Instead of burning the matchbook:
	if the location is the Study:
		say "(lighting the fireplace)[command clarification break]";
		try burning the stone fireplace;
	otherwise:
		say "There[apostrophe]s nothing useful to light here."

Instead of burning the hearthstone:
	try burning the stone fireplace.

Instead of opening the wall safe when the wall safe is locked:
	if the fireplace-lit is false:
		say "The safe has a three-dial combination lock. You don[apostrophe]t know the combination yet.";
	otherwise:
		now the wall safe is unlocked;
		now the wall safe is open;
		say "You dial 7-3-9. The safe clicks open.";
		if the wall safe is unscored:
			now the wall safe is scored;
			increase the score by 1.

The clock spring is in the wall safe. The description of the clock spring is "A tightly coiled metal spring, the kind found inside clockwork."
Understand "spring" and "coiled spring" and "metal spring" and "coil" as the clock spring.

The wood paneling is scenery in the Study. The description of the wood paneling is "Dark wood panels line the walls, polished but dusty."
Understand "paneling" and "panels" and "panel" and "wood" as the wood paneling.

Chapter 4 - Kitchen

The Kitchen is south of the Hallway. "A rustic kitchen with stone counters and a deep ceramic sink. Copper pots hang from hooks above. A handwritten recipe card sits on the counter.[paragraph break]The hallway is north. A doorway leads south to the garden."

The stone counters are scenery in the Kitchen. The description of the stone counters is "Heavy stone countertops, cracked but solid."
Understand "counter" and "countertop" and "countertops" as the stone counters.

The ceramic sink is scenery in the Kitchen. The description of the ceramic sink is "A deep farmhouse sink with a brass faucet. It drips slowly."
Understand "sink" and "faucet" and "tap" and "basin" as the ceramic sink.

Instead of turning the ceramic sink:
	say "You turn the faucet. Rusty water sputters out, then runs clear. You turn it off."

The copper pots are scenery in the Kitchen. The description of the copper pots is "Tarnished copper pots hanging from iron hooks. Decorative now."
Understand "pots" and "pans" and "pot" and "pan" and "hooks" and "iron hooks" as the copper pots.

The recipe card is scenery in the Kitchen. The description of the recipe card is "Your grandmother[apostrophe]s handwriting: [apostrophe]Lavender shortbread -- butter, sugar, flour, and dried lavender from the garden.[apostrophe] The card is stained and well-loved."
Understand "recipe" and "card" and "note" and "handwritten" as the recipe card.

Chapter 5 - Garden

The Garden is south of the Kitchen. "An overgrown garden behind the house. A flower bed runs along the back wall, thick with weeds. A small shed leans in one corner with its door ajar. A rusty trowel leans against the shed.[paragraph break]The kitchen doorway is back to the north."

The flower bed is scenery in the Garden. The description of the flower bed is "A raised bed of dark soil tangled with dead weeds. The earth looks soft -- someone was digging here recently."
Understand "bed" and "flowers" and "weeds" and "soil" and "dirt" and "earth" and "ground" as the flower bed.

The garden shed is scenery in the Garden. The description of the garden shed is "A small wooden shed with a sagging roof. The door hangs open, revealing empty shelves and cobwebs inside."
Understand "shed" and "shack" and "door" and "shed door" and "shelves" and "cobwebs" and "roof" as the garden shed.

The garden trowel is in the Garden. The description of the garden trowel is "A short-handled garden trowel, rusty but solid."
Understand "trowel" and "spade" and "shovel" and "tool" as the garden trowel.

The mechanism is nowhere. The description of the mechanism is "A small brass mechanism -- gears, pins, and a tiny drum with raised bumps. The innards of a music box."
Understand "gears" and "gear" and "clockwork" and "innards" and "brass mechanism" and "drum" and "pins" and "pin" as the mechanism.

Chapter 6 - Attic

The Attic is up from the Hallway. "A cramped attic under sloping eaves, thick with dust. A dusty shelf holds an old music box. A heavy steamer trunk sits against the wall.[paragraph break]The stairs lead back down."

The dusty shelf is a supporter in the Attic. It is fixed in place and scenery. The description of the dusty shelf is "A rough plank shelf nailed to the wall studs."
Understand "shelf" and "plank" and "shelves" as the dusty shelf.

The old music box is an openable open container on the dusty shelf. The carrying capacity of the old music box is 2. The description of the old music box is "A wooden music box with a rose-carved lid and a small keyhole on the side. [if the number of things in the old music box is 0]Inside, the cavity is empty -- the mechanism has been removed.[otherwise if the number of things in the old music box is 1]One part has been placed inside, but something is still missing.[otherwise]The mechanism and spring are both in place. It looks ready to be wound."
Understand "box" and "music box" and "wooden box" and "lid" and "keyhole" as the old music box.

The steamer trunk is a closed openable locked container in the Attic. It is fixed in place. The description of the steamer trunk is "A battered steamer trunk with brass fittings. [if the steamer trunk is locked]The lock has no keyhole -- just a small slot that looks mechanically connected to the shelf above.[otherwise]The mechanical lock has sprung open."
Understand "trunk" and "chest" and "old trunk" and "steamer" and "fittings" and "brass fittings" and "slot" as the steamer trunk.

Instead of unlocking the steamer trunk with something:
	say "The trunk has no keyhole. The lock seems mechanically connected to the shelf above."

The family locket is in the steamer trunk. The description of the family locket is "A silver locket on a fine chain. Inside, a tiny photograph shows your grandmother as a young woman, smiling."
Understand "locket" and "silver locket" and "heirloom" and "necklace" and "chain" and "photograph" and "photo" as the family locket.

After taking the family locket for the first time:
	say "You lift the locket from the trunk. Inside, your grandmother smiles back at you from a faded photograph. This is what she wanted you to have.";
	if the family locket is unscored:
		now the family locket is scored;
		increase the score by 2.

The sloping eaves are scenery in the Attic. The description of the sloping eaves is "Low rafters and dusty beams. You have to duck in places."
Understand "eaves" and "rafters" and "beams" and "ceiling" and "roof" and "wall" and "dust" as the sloping eaves.

Part 3 - Custom Actions

Chapter 1 - Ringing

Ringing is an action applying to one thing.
Understand "ring [something]" as ringing.

Carry out ringing:
	if the noun is the brass doorbell:
		say "(pressing [the noun])[command clarification break]";
		try pushing the brass doorbell;
	otherwise:
		say "You can[apostrophe]t ring [the noun]."

Chapter 2 - Knocking

Knocking on is an action applying to one thing.
Understand "knock on [something]" as knocking on.
Understand "knock [something]" as knocking on.
Understand "rap on [something]" as knocking on.

Carry out knocking on:
	if the noun is the front door:
		say "You rap your knuckles on the door. No answer. You[apostrophe]ll need to let yourself in.";
	otherwise:
		say "You knock on [the noun]. Nothing happens."

Chapter 3 - Kindling Synonyms

Understand "kindle [something]" as burning.
Understand "ignite [something]" as burning.
Understand "start [something]" as burning.

Chapter 4 - Looking Behind

Looking behind is an action applying to one thing.
Understand "look behind [something]" as looking behind.
Understand "check behind [something]" as looking behind.

Carry out looking behind:
	if the noun is the oil painting:
		say "(moving [the noun])[command clarification break]";
		try pushing the oil painting;
	otherwise:
		say "You find nothing behind [the noun]."

Chapter 5 - Digging

Digging is an action applying to one thing.
Understand "dig [something]" as digging.
Understand "dig in [something]" as digging.
Understand "dig up [something]" as digging.
Understand "excavate [something]" as digging.

Check digging:
	if the player does not carry the garden trowel:
		say "You[apostrophe]d need a digging tool. Your bare hands won[apostrophe]t work." instead.

Instead of digging the flower bed:
	if the player does not carry the garden trowel:
		say "The soil is too packed for bare hands. You need a tool." instead;
	if the mechanism is nowhere:
		now the mechanism is in the Garden;
		say "You dig into the soft earth and uncover a small brass mechanism wrapped in oilcloth. It[apostrophe]s the innards of a music box.";
		if the mechanism is unscored:
			now the mechanism is scored;
			increase the score by 1;
	otherwise:
		say "You[apostrophe]ve already dug up everything here."

Digging-here is an action applying to nothing.
Understand "dig" as digging-here.
Understand "dig here" as digging-here.

Carry out digging-here:
	if the player is in the Garden:
		say "(digging the flower bed)[command clarification break]";
		try digging the flower bed;
	otherwise:
		say "There[apostrophe]s nothing to dig here."

Chapter 6 - Winding

Winding is an action applying to one thing.
Understand "wind [something]" as winding.
Understand "wind up [something]" as winding.
Understand "crank [something]" as winding.

Winding it with is an action applying to two things.
Understand "wind [something] with [something]" as winding it with.
Understand "wind up [something] with [something]" as winding it with.
Understand "crank [something] with [something]" as winding it with.

Instead of winding something with something:
	try winding the noun.

Check winding:
	if the noun is not the old music box:
		say "You can[apostrophe]t wind [the noun]." instead;
	if the player does not carry the winding key:
		say "You[apostrophe]d need something to wind it with -- a small key, perhaps." instead;
	if the mechanism is not in the old music box:
		say "The music box cavity is empty. It needs its mechanism." instead;
	if the clock spring is not in the old music box:
		say "The music box is missing its spring. It won[apostrophe]t hold tension." instead.

Carry out winding:
	say "You insert the butterfly key into the keyhole and wind the music box. The gears catch and a delicate melody fills the attic.[paragraph break]As the tune plays, you hear a click from the steamer trunk -- its mechanical lock releases and the lid swings open.";
	now the steamer trunk is unlocked;
	now the steamer trunk is open;
	if the old music box is unscored:
		now the old music box is scored;
		increase the score by 2.

Chapter 7 - Repairing

Repairing is an action applying to one thing.
Understand "fix [something]" as repairing.
Understand "repair [something]" as repairing.
Understand "assemble [something]" as repairing.
Understand "mend [something]" as repairing.

Instead of repairing the old music box:
	if the mechanism is not in the old music box and the clock spring is not in the old music box:
		say "The music box needs its mechanism and spring. Try putting them inside.";
	otherwise if the mechanism is not in the old music box:
		say "The music box still needs its mechanism.";
	otherwise if the clock spring is not in the old music box:
		say "The music box still needs its spring.";
	otherwise:
		say "The parts are in place. Try winding it."

Instead of repairing something:
	say "[The noun] doesn[apostrophe]t seem to need fixing."

Chapter 8 - Assembly Synonyms

Understand "attach [something] to [something]" as inserting it into.
Understand "install [something] in [something]" as inserting it into.

Combining it with is an action applying to two things.
Understand "combine [something] with [something]" as combining it with.

Instead of combining something with something:
	if the second noun is the old music box:
		try inserting the noun into the old music box;
	otherwise if the noun is the old music box:
		try inserting the second noun into the old music box;
	otherwise:
		say "You can[apostrophe]t combine those. Try PUT [the noun] IN something."

Chapter 9 - Additional Verb Synonyms

Understand the command "rummage" as "search".
Understand the command "flip" as "examine".
Understand the command "browse" as "examine".
Understand the command "investigate" as "examine".
Understand the command "slide" as "push".
Understand "look around" as looking.
Understand "upstairs" as up.
Understand "downstairs" as down.
Understand "help me" as requesting help.

Chapter 10 - Question Forms

[Where am I / what is this place → LOOK]
Where-asking is an action out of world applying to nothing.
Understand "where am i" and "where" and "what is this place" and "what is this" as where-asking.

Carry out where-asking:
	say "You are in [the location of the player]."

[What do I have / what am I carrying → INVENTORY]
Understand "what do i have" and "what am i carrying" and "what am i holding" and "check my inventory" and "check inventory" and "my inventory" as taking inventory.

[What can I do → HELP]
Understand "what can i do" and "what can i do here" as requesting help.

Chapter 11 - Navigation Idioms

[Go inside/outside — try going through the door or a reasonable direction]
Going-inside is an action applying to nothing.
Understand "go inside" as going-inside.

Carry out going-inside:
	let found be false;
	repeat with D running through directions:
		let the way be the room D from the location of the player;
		if the way is a room:
			let the portal be the door D from the location of the player;
			if the portal is a door and the portal is open:
				say "(going [D])[command clarification break]";
				try going D;
				now found is true;
				stop;
	if found is false:
		say "Use compass directions to move: NORTH, EAST, UP, etc."

Going-outside is an action applying to nothing.
Understand "go outside" and "go out" as going-outside.

Carry out going-outside:
	if the location is the Kitchen:
		say "(going south)[command clarification break]";
		try going south;
	otherwise if the location is the Hallway:
		say "(going west)[command clarification break]";
		try going west;
	otherwise:
		say "Use compass directions to move: NORTH, SOUTH, EAST, etc."

[Go through the door]
Going-through is an action applying to one thing.
Understand "go through [something]" and "walk through [something]" as going-through.

Carry out going-through:
	if the noun is a door:
		let the way be the direction of the noun from the location of the player;
		if the way is a direction:
			say "(going [the way])[command clarification break]";
			try going the way;
		otherwise:
			say "You can[apostrophe]t go through [the noun] from here.";
	otherwise:
		say "You can[apostrophe]t walk through [the noun]."

[Leave / leave the room → go back the way you came]
The previous-room is a room that varies. The previous-room is the Front Porch.
The has-moved is a truth state that varies. The has-moved is false.

Before going:
	now the previous-room is the location of the player;
	now the has-moved is true.

Leaving-room is an action applying to nothing.
Understand "leave" as leaving-room.

Carry out leaving-room:
	if the has-moved is false:
		say "You haven[apostrophe]t been anywhere else yet.";
	otherwise if the previous-room is the location of the player:
		say "You[apostrophe]re not sure where to go. Try a compass direction: NORTH, EAST, etc.";
	otherwise:
		let the way be the best route from the location of the player to the previous-room, using doors;
		if the way is a direction:
			say "(going [the way])[command clarification break]";
			try going the way;
		otherwise:
			say "You can[apostrophe]t find a way back. Try a compass direction."

Instead of exiting when the player is not in a container and the player is not on a supporter:
	try leaving-room.

[Go back / back / return]
Going-back is an action applying to nothing.
Understand "go back" and "back" and "return" and "go back inside" as going-back.

Carry out going-back:
	try leaving-room.

[Go to <room name> → friendly redirect]
Understand "go to [text]" and "enter [text]" as a mistake ("Use compass directions to move: GO NORTH, EAST, UP, etc. Type LOOK to see available exits.").

[Head east / walk east — already covered by "walk" as "go" and "head" as "go"]

Chapter 12 - Self-Examination

The description of the player is "As good-looking as ever."
Understand "myself" as yourself.

Chapter 13 - Room and Ambience Phrases

["Look at everything" / "look at this room" / "examine room" → LOOK]
Understand "look at everything" and "examine everything" and "look at this room" and "look at this place" and "examine room" and "describe room" and "look at the room" as looking.

["Hello" and other greetings]
Greeting is an action out of world applying to nothing.
Understand "hello" and "hi" and "hey" as greeting.

Carry out greeting:
	say "No one answers. The house is quiet. Type LOOK to see your surroundings, or HELP for hints."

Chapter 14 - Entity Alias Expansions

[Corner of doormat]
Understand "corner" as the woven doormat.

[Flip through / leaf through / read through → examine]
Understand "flip through [something]" and "leaf through [something]" and "read through [something]" and "browse through [something]" as examining.

Part 4 - Verb Help System

Chapter 1 - Enhanced Parser Errors

Rule for printing a parser error when the latest parser error is the not a verb I recognise error:
	say "I don[apostrophe]t know that command. Type VERBS for a list, or try simpler phrasing like VERB NOUN."

Rule for printing a parser error when the latest parser error is the didn't understand error:
	say "I understood some words but not the whole command. Try: VERB NOUN (e.g., TAKE KEY, OPEN DOOR)."

Rule for printing a parser error when the latest parser error is the can't see any such thing error:
	say "You don[apostrophe]t see that here. Try LOOK to see what[apostrophe]s around, or INVENTORY to check what you carry."

Rule for printing a parser error when the latest parser error is the said too little error:
	say "That command needs more detail. Try VERB NOUN (e.g., EXAMINE TABLE, not just EXAMINE)."

Rule for printing a parser error when the latest parser error is the only understood as far as error:
	say "I only understood part of that. Try rephrasing with a simpler command."

Chapter 2 - Help and Verbs Commands

Requesting the verb list is an action out of world applying to nothing.
Understand "verbs" and "commands" as requesting the verb list.

Carry out requesting the verb list:
	say "Movement:  NORTH (N), SOUTH (S), EAST (E), WEST (W), UP (U), DOWN (D), IN, OUT[line break]";
	say "Looking:   LOOK (L), EXAMINE (X) thing, SEARCH thing, LOOK IN/UNDER thing[line break]";
	say "Taking:    TAKE thing, DROP thing, PUT thing IN/ON thing[line break]";
	say "Using:     OPEN, CLOSE, LOCK/UNLOCK thing WITH key, PUSH, PULL, TURN[line break]";
	say "Special:   DIG thing, WIND thing, LIGHT thing, RING thing, KNOCK ON thing[line break]";
	say "Assembly:  PUT thing IN thing, ATTACH thing TO thing, FIX thing[line break]";
	say "Self:      INVENTORY (I), WAIT (Z), WEAR thing, EAT thing[line break]";
	say "Meta:      SAVE, RESTORE, UNDO, SCORE, HELP, VERBS, RESTART, QUIT".

Requesting help is an action out of world applying to nothing.
Understand "help" and "hint" and "hints" as requesting help.

Carry out requesting help:
	say "You[apostrophe]re exploring your grandmother[apostrophe]s old house looking for an heirloom she left.[paragraph break]";
	say "Search everywhere -- under things, behind things, inside things.[line break]";
	say "Pick up useful objects and try combining them.[line break]";
	say "If something seems broken, look for its missing parts.[paragraph break]";
	say "Type VERBS for a full list of commands. Most puzzles use VERB NOUN."

Chapter 3 - Common Synonyms

[Examination -- standard has: examine, x, look at, read, watch]
Understand the command "inspect" as "examine".
Understand the command "study" as "examine".
Understand the command "view" as "examine".
Understand the command "peruse" as "examine".

[Taking -- standard has: take, get, pick up, carry]
Understand the command "grab" as "take".
Understand the command "collect" as "take".
Understand the command "acquire" as "take".
Understand the command "snag" as "take".
Understand the command "fetch" as "take".
Understand the command "obtain" as "take".
Understand the command "steal" as "take".
Understand the command "nab" as "take".
Understand the command "lift" as "take".

[Combat -- standard has: attack, hit, fight, punch, kill, smash, break]
Understand the command "strike" as "attack".
Understand the command "stab" as "attack".
Understand the command "slash" as "attack".
Understand the command "kick" as "attack".

[Looking -- standard has: look, l]
Understand the command "peek" as "look".
Understand the command "peer" as "look".
Understand the command "gaze" as "look".

[Going -- standard has: go + compass directions]
Understand the command "proceed" as "go".
Understand the command "head" as "go".

[Opening -- standard has: open, uncover, unwrap]
Understand the command "pry" as "open".
Understand the command "force" as "open".

[Dropping -- standard has: drop, throw, discard]
Understand the command "toss" as "drop".

[Putting -- standard has: put, insert]
Understand the command "place" as "put".

[Pushing -- standard has: push, move, shift, clear, press]
Understand the command "shove" as "push".
Understand the command "prod" as "push".

[Pulling -- standard has: pull, drag]
Understand the command "yank" as "pull".

[Eating -- standard has: eat]
Understand the command "consume" as "eat".
Understand the command "devour" as "eat".

[Communication -- specific patterns for natural phrasing]
Understand "talk to [someone] about [text]" as asking it about.
Understand "speak to [someone] about [text]" as asking it about.
Understand "chat with [someone] about [text]" as asking it about.
Understand "talk to [someone]" as a mistake ("To talk, try ASK person ABOUT topic or TELL person ABOUT topic.").
Understand "speak to [someone]" as a mistake ("To talk, try ASK person ABOUT topic or TELL person ABOUT topic.").
Understand "chat with [someone]" as a mistake ("To talk, try ASK person ABOUT topic or TELL person ABOUT topic.").

Chapter 4 - USE Verb Handler

Generically-using is an action applying to one thing.
Understand "use [something]" as generically-using.

Check generically-using:
	say "How do you want to use [the noun]? Try a specific verb: OPEN, PUSH, PULL, TURN, EAT, WEAR, etc." instead.

Generically-using it with is an action applying to two things.
Understand "use [something] on [something]" as generically-using it with.
Understand "use [something] with [something]" as generically-using it with.

Carry out generically-using it with:
	if the second noun is lockable:
		try unlocking the second noun with the noun;
	otherwise:
		say "Try a specific command, such as PUT [the noun] ON [the second noun] or GIVE [the noun] TO [the second noun]."

Part 5 - Winning

Every turn:
	if the score is 10:
		say "[paragraph break][bold type]You found your grandmother[apostrophe]s heirloom.[roman type] The locket feels warm against your palm.";
		end the story finally saying "You have won".
