to show-me
  ca
  ask patches [set pcolor 8]
  if level = 1 [
    if character = "Player" [
      crt 1 [set shape "cavemen" set size 10 set color 28]
      output-type "Caveman"
    ]
    if character = "Fast enemy" [
      crt 1 [set shape "pterodactyl" set size 10 set color black]
      output-type "Pterodactyl"
    ]
    if character = "Strong enemy" [
      crt 1 [set shape "st tiger" set size 10]
      output-type "Sabre-Tooth Tiger"
    ]
    if character = "Long-range enemy" [
      crt 1 [set shape "neanderthal" set size 10]
      output-type "Neanderthal"
    ]
    if character = "Powerups" [
      crt 1 [set shape "box" set size 10]
      output-type "Powerup Box"
    ]
    if character = "Boss" [
      crt 1 [set shape "t-rex" set size 10 set color 53.5 set heading 270]
      output-type "T-rex"
    ]
    if character = "Boss extras" [
      crt 1 [set shape "tree pine" set size 6 set color 53.5]
      output-type "Tree Projectiles"
    ]
    if character = "Decoration" [
      crt 1 [set shape "tree" set size 10 set color 53]
      output-type "Tree"
    ]
  ]
  if level = 2 [
    if character = "Player" [
      crt 1 [set shape "spartan" set size 10 set color 28]
      output-type "Spartan"
    ]
    if character = "Fast enemy" [
      crt 1 [set shape "centaur" set size 10]
      output-type "Centaur"
    ]
    if character = "Strong enemy" [
      crt 1 [set shape "cyclops" set size 10]
      output-type "Cyclops"
    ]
    if character = "Long-range enemy" [
      crt 1 [set shape "medusa" set size 10]
      output-type "Medusa"
    ]
    if character = "Powerups" [
      crt 1 [set shape "box" set size 10]
      output-type "Powerup Box"
    ]
    if character = "Boss" [
      crt 1 [set shape "minotaur" set size 10 set color 36.5]
      output-type "Minotaur"
    ]
    if character = "Boss extras" [
      crt 1 [set shape "cow skull" set size 10 set color white]
      output-type "Dead Minotaur"
    ]
    if character = "Decoration" [
      crt 1 [set shape "column" set size 10 set color grey]
      output-type "Column"
    ]
  ]
  if level = 3 [
    if character = "Player" [
      crt 1 [set shape "knight" set size 10 set color 28]
      output-type "Knight"
    ]
    if character = "Fast enemy" [
      crt 1 [set shape "viking" set size 10]
      output-type "Viking"
    ]
    if character = "Strong enemy" [
      crt 1 [set shape "troll" set size 10]
      output-type "Trolls"
    ]
    if character = "Long-range enemy" [
      crt 1 [set shape "dark elf" set size 10]
      output-type "Dark Elf"
    ]
    if character = "Boss" [
      crt 1 [set shape "dragon" set size 10 set color 12.5 set heading 270]
      output-type "Dragon"
    ]
    if character = "Boss extras" [
      crt 1 [set shape "well" set color blue set size 5 setxy -3 5]
      crt 1 [set shape "well" set color brown set size 5 setxy -3 -1]
      crt 1 [set shape "fireball" set color 12.5 set size 5 setxy 3 2]
      output-type "Wells & Fireball"
    ]
    if character = "Powerups" [
      crt 1 [set shape "box" set size 10]
      output-type "Powerup Box"
    ]
    if character = "Decoration" [
      crt 1 [set shape "tower" set size 10 set color grey]
      output-type "Tower"
    ]
  ]
  if level = 4 [
    if character = "Player" [
      crt 1 [set shape "worker" set size 10 set color 28]
      output-type "Day Laborer"
    ]
    if character = "Fast enemy" [
      crt 1 [set shape "bartender" set size 10 set color 28]
      output-type "Bartender"
    ]
    if character = "Strong enemy" [
      crt 1 [set shape "capitalist" set size 10 set color 28]
      output-type "Capitalist"
    ]
    if character = "Long-range enemy" [
      crt 1 [set shape "general" set size 10 set color green]
      output-type "General"
    ]
    if character = "Boss" [
        crt 1 [set shape "tempg" set size 10 set color black]
        output-type "Is that a teacher?!"
    ]
    if character = "Boss extras" [
        crt 1 [set shape "essay" set size 5 set color white]
        output-type "Graded Essay"
      ]
    if character = "Powerups" [
      crt 1 [set shape "box" set size 10]
      output-type "Powerup Box"
    ]
    if character = "Decoration" [
      crt 1 [set shape "factory" set size 10 set color grey]
      output-type "Factory"
    ]
  ]
  if level = 5 [
    if character = "Player" [
      crt 1 [set shape "student" set size 10 set color 28]
      output-type "Student"
    ]
    if character = "Fast enemy" [
      crt 1 [set shape "skateboarder" set size 10 set color 28]
      output-type "Skateboarder"
    ]
    if character = "Strong enemy" [
      crt 1 [set shape "homeless" set size 10 set color 28]
      output-type "Homeless Man"
    ]
    if character = "Long-range enemy" [
      crt 1 [set shape "thug" set size 10 set color 28]
      output-type "Thug"
    ]
    if character = "Boss" [
      crt 1 [set shape "train passenger car" set color 5 set size 10]
      output-type "Subway"
    ]
    if character = "Boss extras" [
      crt 1 [set shape "rat" set size 5 set color grey]
      output-type "Rat"
    ]
    if character = "Powerups" [
      crt 1 [set shape "box" set size 10]
      output-type "Powerup Box"
    ]
    if character = "Decoration" [
      crt 1 [set shape "store" set size 10 set color grey]
      output-type "Supermarket"
    ]
  ]
  if level = 6 [
    if character = "Player" [
      crt 1 [set shape "survivor" set size 10 set color 28]
      output-type "Survivor"
    ]
    if character = "Fast enemy" [
      crt 1 [set shape "ufo side" set size 10 set color black]
      output-type "UFO"
    ]
    if character = "Strong enemy" [
      crt 1 [set shape "zombie" set size 10 set color green]
      output-type "Zombie"
    ]
    if character = "Long-range enemy" [
      crt 1 [set shape "alien" set size 10]
      output-type "Alien"
    ]
    if character = "Boss" [
      crt 1 [set shape "Alien Overlord" set size 10]
      output-type "Alien Overlord"
    ]
    if character = "Boss extras" [
      ask patch -1 -1 [set pcolor orange]
      ask patch -1 1 [set pcolor blue]
      ask patch 1 1 [set pcolor green]
      ask patch 1 -1 [set pcolor yellow]
      output-type "Musical Buttons"
    ]
    if character = "Powerups" [
      crt 1 [set shape "box" set size 10]
      output-type "Powerup Box"
    ]
    if character = "Decoration" [
      crt 1 [set shape "bud" set size 10 set color one-of [black red]]
      output-type "Alien Bud"
    ]
  ]
  if level = 7 [
    if character = "Player" [
      crt 1 [set shape "cyborg" set size 10 set color 28]
      output-type "Cyborg"
    ]
    if character = "Fast enemy" [
      crt 1 [set shape "robot" set size 10 set color black]
      output-type "Robot"
    ]
    if character = "Strong enemy" [
      crt 1 [set shape "elderly" set size 10 set color 28]
      output-type "Elderly"
    ]
    if character = "Long-range enemy" [
      crt 1 [set shape "terminator" set size 10 set color grey]
      output-type "Terminator"
    ]
    if character = "Boss" [
      crt 1 [set shape "brain" set size 10]
      output-type "Giant Brain"
    ]
    if character = "Boss extras" [
      crt 1 [set shape "wave" set size 5 setxy -3 0]
      crt 1 [set shape "juice" set size 5 setxy 3 0]
      output-type "Electric wave & Juice"
    ]
    if character = "Powerups" [
      crt 1 [set shape "box" set size 10]
      output-type "Powerup Box"
    ]
    if character = "Decoration" [
      crt 1 [set shape "column" set size 10 set color grey]
      output-type "Column"
    ]
  ]
    if level = 8 [
    if character = "Player" [
      crt 1 [set shape "glitch" set size 10 set color random 130]
      output-type "<!--- // --->"
    ]
    if character = "Fast enemy" [
      crt 1 [set shape "glitch" set size 10 set color random 130]
      output-type "<!--- // --->"
    ]
    if character = "Strong enemy" [
      crt 1 [set shape "glitch" set size 10 set color random 130]
      output-type "<!--- // --->"
    ]
    if character = "Long-range enemy" [
      crt 1 [set shape "glitch" set size 10 set color random 130]
      output-type "<!--- // --->"
    ]
    if character = "Boss" [
        crt 1 [set shape "tempk" set size 10 set color black]
        output-type "Is that a teacher?!"
    ]
    if character = "Boss extras" [
      output-type "I need no extras, fool!"
    ]
    if character = "Powerups" [
      crt 1 [set shape "box" set size 10]
      output-type "Powerup Box"
    ]
    if character = "Decoration" [
      crt 1 [set shape "glitch" set size 10 set color random 130]
      output-type "<!--- // --->"
    ]
  ]
end
@#$#@#$#@
GRAPHICS-WINDOW
210
10
649
470
16
16
13.0
1
10
1
1
1
0
1
1
1
-16
16
-16
16
0
0
1
ticks
30.0

CHOOSER
30
127
182
172
Character
Character
"Player" "Fast enemy" "Strong enemy" "Long-range enemy" "Boss" "Boss extras" "Powerups" "Decoration"
4

CHOOSER
30
73
182
118
Level
Level
1 2 3 4 5 6 7 8
4

BUTTON
41
228
112
261
Display
show-me
NIL
1
T
OBSERVER
NIL
D
NIL
NIL
1

OUTPUT
267
346
584
400
20

@#$#@#$#@
## WHAT IS IT?

This is a companion guide to the Maze of Historic Proportions. It includes tips and art for beating the game.

## HOW TO USE IT

Simple - choose the level and character, press display, and marvel at our glorious drawing skills. Or, read the tips in the Info tab, which you are currently viewing.

## ABOUT THE GAME
## Levels
The game is divided into eight history-themed levels, in chronological order (but, naturally, with non-chronological data. What do you expect here, a textbook?!) After each level, there is a boss level, with the bosses in levels 4 and 8 acting as a mid-way boss and a main boss, respectively.

## Weapons
In each level, there are three types of enemies: Fast, Strong, and Long-Range. You will notice that this corresponds to the three weapon types: Fast, Strong, and Long-Range. The way that the game is set up, the enemy/weapon types follow a certain rule:
	1. Fast is effective against Strong
	2. Strong is effective against Long-Range
	3. Long-Range is effective against Fast
Use this knowledge to your advantage.

## Enemies
Each enemy type has its own "personality," based on what type of enemy it is. The personalities are listed below:
	1. Fast: double speed, regular attack, regular health, regular sight
	2. Strong: half speed, double attack, higher health, weaker sight
	3. Long-Range: regular speed, weaker attack, regular health, stronger sight, 				attacks from afar

## Power-ups
In addition to this, there will, at random times, appear certain packages. These packages act as power-ups, and affect the player in one of three ways:
	1. Heal the player
	2. Increase the player's strength
	3. Do nothing at all

## Bosses
Each boss requires a certain task to be performed - it can be a puzzle, or it can require physical action. In other words, it is harder than the actual mazes (if that is possible)

## TIPS

Make sure that sound is working, and that the buttons have a black symbol in them to indicate keyboard controls.

Try to sneak past the Strong enemies. They are hard to kill, take off a lot of damage, and are often accompanied by other enemies. Another solution is to use Long-Range weapons to kill them without being noticed.

Plan out the route before starting to move. Also, if low on health, try to find a safe point out of reach from the enemies, so as to regenerate health.

The Messages on top are important! Read them at the beginning of the level, and, when it says "Ready..." scroll down. This is why using a mouse is encouraged (besides the virtual need for it on Bosses 4 and 8).

## SPONSORS AND CREDITS

Coding - Alon Levin and Joseph Gelb
Character design - Alon Levin, Joseph Gelb, and the Netlogo Library
Maze design - Alon Levin and Joseph Gelb
Game testers - Alon Levin, Joseph Gelb, Maxim Minchuk, Mary Amigud, Bronis Levin
Sponsors - Oak Enterprises

## SPONSOR MESSAGE

Oak Enterprises - where you share your games and models! Come on over to our site and browse the many creations offered. Made by Alon Levin and Avery Karlin
tinyurl.com/oakenterprises
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

alien
false
0
Polygon -7500403 true true 150 15 120 30 120 45 120 75 144 81 127 96 129 113 144 134 136 185 135 195 120 195 135 195 150 180 165 195 165 184 157 134 170 115 173 95 156 81 180 75 181 42 180 30
Polygon -7500403 true true 150 167 159 185 190 182 225 212 255 257 240 212 200 170 154 172
Polygon -7500403 true true 161 167 201 150 237 149 281 182 245 140 202 137 158 154
Polygon -7500403 true true 155 135 185 120 230 105 270 135 233 115 201 124 155 150
Polygon -7500403 true true 145 135 115 120 70 105 30 135 67 115 99 124 145 150
Polygon -7500403 true true 139 167 105 165 75 180 45 225 60 165 105 150 142 154
Polygon -7500403 true true 150 167 141 185 110 182 75 212 45 257 60 212 100 170 146 172
Circle -16777216 true false 126 35 15
Circle -16777216 true false 157 35 15

alien overlord
false
0
Polygon -10899396 true false 113 86 131 190 121 280 101 296 131 296 149 174 161 296 191 296 172 282 167 189 183 86
Rectangle -10899396 true false 134 81 165 94
Polygon -10899396 true false 116 88 72 138 79 143 130 97
Polygon -10899396 true false 150 9 183 21 182 50 161 84 156 88 152 91 147 91 144 90 134 84 117 54 115 41 126 11
Polygon -10899396 true false 180 86 224 136 217 141 166 95
Rectangle -10899396 true false 215 135 223 194
Polygon -10899396 true false 223 194 228 207 228 216 215 221 215 193
Polygon -10899396 true false 78 144 61 87 66 68 60 78 57 59 57 80 50 66 70 146
Polygon -14835848 true false 129 29 144 34 142 41 126 43 124 38
Polygon -14835848 true false 169 31 154 36 156 43 172 45 174 40
Polygon -14835848 true false 134 65 160 62 160 69
Line -16777216 false 130 22 143 29
Line -16777216 false 169 22 155 30
Polygon -1 true false 147 109 144 115 161 108

bartender
false
0
Polygon -7500403 true true 180 195 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285
Polygon -1 true false 120 90 105 90 60 195 90 210 120 150 120 195 180 195 180 150 210 210 240 195 195 90 180 90 165 105 150 165 135 105 120 90
Polygon -1 true false 123 90 149 141 177 90
Rectangle -7500403 true true 123 76 176 92
Circle -7500403 true true 110 5 80
Line -13345367 false 121 90 194 90
Line -16777216 false 148 143 150 196
Rectangle -16777216 true false 116 186 182 198
Circle -1 true false 152 143 9
Circle -1 true false 152 166 9
Rectangle -16777216 true false 179 164 183 186
Polygon -2674135 true false 180 90 195 90 183 160 180 195 150 195 150 135 180 90
Polygon -2674135 true false 120 90 105 90 114 161 120 195 150 195 150 135 120 90
Polygon -2674135 true false 145 91 172 77 172 101
Polygon -2674135 true false 155 91 128 77 128 101
Rectangle -955883 true false 251 162 281 207
Polygon -1184463 true false 250 171 241 172 241 181 241 193 245 198 248 201 250 197 246 193 246 178 249 177
Circle -1 true false 251 154 10
Circle -1 true false 258 153 10
Circle -1 true false 265 154 10
Circle -1 true false 270 154 10
Line -16777216 false 255 210 255 165
Line -16777216 false 270 210 270 165
Line -16777216 false 263 210 263 165

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

brain
false
3
Circle -2064490 true false 223 28 94
Circle -2064490 true false 26 71 96
Circle -2064490 true false 180 45 120
Circle -2064490 true false 106 26 120
Circle -2064490 true false 45 39 120
Circle -2064490 true false 48 138 85
Circle -2064490 true false 93 138 85
Circle -2064490 true false 138 138 85
Circle -2064490 true false 183 138 85
Circle -2064490 true false 228 138 85
Rectangle -7500403 true false 82 215 275 245
Rectangle -10899396 true false 56 245 295 281
Circle -1 true false 91 131 58
Circle -1 true false 209 132 58
Circle -13791810 true false 111 154 26
Circle -13791810 true false 218 153 26
Line -16777216 false 105 116 146 134
Line -16777216 false 245 110 210 138
Polygon -2674135 true false 87 57 74 69 65 79 65 87 59 103 66 109 72 108
Polygon -2674135 true false 168 34 155 46 146 56 146 64 140 80 147 86 153 85
Polygon -2674135 true false 255 38 268 50 277 60 277 68 283 84 276 90 270 89
Polygon -2674135 true false 231 50 218 62 209 72 209 80 196 56 218 78 219 74
Line -16777216 false 186 169 166 205
Line -16777216 false 167 207 182 208
Polygon -2674135 true false 297 173 284 185 275 195 275 203 285 174 284 201 285 197

bud
false
0
Polygon -7500403 true true 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Polygon -7500403 true true 189 233 219 188 249 173 279 188 234 218
Polygon -7500403 true true 180 255 150 210 105 210 75 240 135 240
Polygon -7500403 true true 180 150 180 120 165 97 135 84 128 121 147 148 165 165
Polygon -7500403 true true 170 155 131 163 175 167 196 136

capitalist
false
0
Rectangle -1 true false 120 90 180 180
Polygon -13345367 true false 135 90 150 105 135 180 150 195 165 180 150 105 165 90
Polygon -14835848 true false 120 88 105 88 60 193 90 208 116 152 109 177 90 283 105 298 135 298 150 223 165 298 195 298 210 283 194 183 183 151 210 208 240 193 195 88 180 88 150 163
Circle -7500403 true true 110 5 80
Rectangle -7500403 true true 127 76 172 91
Line -16777216 false 172 90 161 94
Line -16777216 false 128 90 139 94
Polygon -6459832 true false 195 227 195 302 270 272 270 197
Rectangle -16777216 true false 180 226 195 301
Polygon -16777216 true false 209 202 209 216 244 202 243 188
Line -16777216 false 180 90 150 165
Line -16777216 false 120 90 150 165
Polygon -6459832 true false 107 194 90 284 105 300 138 300 151 227 164 300 180 299 180 224 200 219 195 194
Polygon -16777216 true false 180 226 195 226 270 196 255 196
Rectangle -16777216 true false 106 18 189 39
Rectangle -16777216 true false 120 -13 180 20
Polygon -1184463 true false 247 227 232 234 233 241 243 249 247 261 241 270 228 280 228 273 233 267 238 260 238 253 234 251 231 245 227 230 234 223 245 222
Rectangle -1184463 true false 235 210 239 282

cavemen
false
13
Circle -2064490 true true 110 20 80
Polygon -2064490 true true 108 89 123 194 93 299 108 299 138 299 153 224 168 299 198 299 213 299 183 194 198 89
Rectangle -7500403 true false 135 75 172 94
Polygon -2064490 true true 195 90 254 157 225 180 165 105
Polygon -2064490 true true 105 90 45 154 75 180 135 105
Polygon -6459832 true false 105 60 195 60 180 120 135 120 105 60
Line -2064490 true 150 225 165 225
Polygon -6459832 true false 120 45 105 45 195 45 180 15 120 15 105 45
Polygon -6459832 true false 120 45 105 75 105 45
Circle -16777216 true false 149 43 12
Circle -16777216 true false 152 46 6
Circle -16777216 true false 172 42 12
Polygon -10899396 true false 145 203 137 221 145 221 143 237 150 233 152 246 156 234 159 236 155 226 154 222 170 225 153 204 149 198 146 206
Polygon -2064490 true true 149 72 183 72 167 88 149 89 137 71 152 71
Line -6459832 false 147 76 171 78

centaur
false
0
Polygon -6459832 true false 200 253 197 309 179 309 177 256 166 247 140 249 93 251 78 239 72 271 49 269 48 241 37 209 25 180 25 149 45 132 103 144 180 135 180 75 195 45 225 90 240 120 240 180 240 210 224 227
Polygon -6459832 true false 73 270 86 311 62 309 48 268
Polygon -6459832 true false 25 159 16 240 9 249 23 258 25 245 39 168
Circle -1184463 true false 191 30 60
Polygon -1184463 true false 180 135 240 210 240 120 225 90 195 45 180 75 180 135
Circle -16777216 true false 228 42 10
Polygon -16777216 true false 213 37 184 64 180 93 180 119 178 142 160 143 141 143 144 137 158 134 167 133 172 129 172 120 174 114 175 97 175 88 175 77 177 72 177 70 180 61 182 58 182 53 184 51 189 48 190 45 195 34 198 33 201 32 211 32
Line -16777216 false 221 37 234 41
Circle -2064490 true false 225 116 8

column
false
0
Rectangle -7500403 true true 90 90 210 270
Polygon -1 true false 210 270 255 240 255 60 210 90
Polygon -13345367 true false 90 90 45 60 45 240 90 270
Polygon -11221820 true false 45 60 90 30 210 30 255 60 210 90 90 90

cow skull
false
0
Polygon -7500403 true true 150 90 75 105 60 150 75 210 105 285 195 285 225 210 240 150 225 105
Polygon -16777216 true false 150 150 90 195 90 150
Polygon -16777216 true false 150 150 210 195 210 150
Polygon -16777216 true false 105 285 135 270 150 285 165 270 195 285
Polygon -7500403 true true 240 150 263 143 278 126 287 102 287 79 280 53 273 38 261 25 246 15 227 8 241 26 253 46 258 68 257 96 246 116 229 126
Polygon -7500403 true true 60 150 37 143 22 126 13 102 13 79 20 53 27 38 39 25 54 15 73 8 59 26 47 46 42 68 43 96 54 116 71 126

cyborg
false
0
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Polygon -13345367 true false 135 90 150 105 135 135 150 150 165 135 150 105 165 90
Polygon -7500403 true true 105 90 60 195 90 210 135 105
Polygon -7500403 true true 195 90 240 195 210 210 165 105
Circle -7500403 true true 110 5 80
Rectangle -7500403 true true 127 79 172 94
Polygon -16777216 true false 105 90 60 195 90 210 114 156 120 195 90 270 210 270 180 195 186 155 210 210 240 195 195 90 165 90 150 150 135 90
Line -16777216 false 150 148 150 270
Line -16777216 false 196 90 151 149
Line -16777216 false 104 90 149 149
Circle -7500403 true true 52 200 30
Line -16777216 false 150 195 165 195
Line -16777216 false 150 240 165 240
Line -16777216 false 150 150 165 150
Circle -16777216 true false 149 27 10
Circle -2674135 true false 166 27 12
Circle -7500403 true true 216 201 30
Line -16777216 false 142 61 187 61

cyclops
false
0
Polygon -955883 true false 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Polygon -1 true false 60 195 90 210 114 154 120 195 180 195 187 157 210 210 240 195 195 90 165 90 150 105 150 150 135 90 105 90
Circle -955883 true false 110 5 80
Rectangle -955883 true false 127 79 172 94
Polygon -13345367 true false 120 90 120 180 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 180 90 172 89 165 135 135 135 127 90
Line -16777216 false 225 90 270 90
Line -16777216 false 225 15 225 90
Line -16777216 false 270 15 270 90
Line -16777216 false 247 15 247 90
Rectangle -6459832 true false 240 90 255 300
Circle -1 true false 129 21 42
Circle -7500403 true true 134 27 31
Circle -1 true false 139 32 21
Circle -16777216 true false 142 36 14
Polygon -6459832 true false 116 4 113 21 71 33 71 40 109 48 117 34 144 27 180 26 188 36 224 23 222 14 178 16 167 0

dark elf
false
0
Polygon -1 true false 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Polygon -8630108 true false 60 196 90 211 114 155 120 196 180 196 187 158 210 211 240 196 195 91 165 91 150 106 150 135 135 91 105 91
Circle -1 true false 110 5 80
Rectangle -1 true false 127 79 172 94
Polygon -6459832 true false 174 90 181 90 180 195 165 195
Polygon -14835848 true false 180 195 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285
Polygon -6459832 true false 126 90 119 90 120 195 135 195
Rectangle -6459832 true false 45 180 255 195
Polygon -16777216 true false 255 165 255 195 240 225 255 240 285 240 300 225 285 195 285 165
Line -16777216 false 135 165 165 165
Line -16777216 false 135 135 165 135
Line -16777216 false 90 135 120 135
Line -16777216 false 105 120 120 120
Line -16777216 false 180 120 195 120
Line -16777216 false 180 135 210 135
Line -16777216 false 90 150 105 165
Line -16777216 false 225 165 210 180
Line -16777216 false 75 165 90 180
Line -16777216 false 210 150 195 165
Line -16777216 false 180 105 210 180
Line -16777216 false 120 105 90 180
Line -16777216 false 150 135 150 165
Circle -16777216 true false 128 32 12
Circle -16777216 true false 160 32 12
Polygon -8630108 true false 100 30 104 44 189 24 185 10 173 10 166 1 138 -1 111 3 109 28

dragon
true
0
Polygon -2674135 true false 45 195 30 180 15 180 15 195 30 195 45 210
Polygon -2674135 true false 45 120 30 105 15 105 15 120 30 120 45 135
Polygon -7500403 true true 75 210 75 240 105 240 150 225 165 225 195 240 165 225 225 210 255 210 285 210 285 180 285 165 270 60 255 45 240 45 225 60 210 75 210 120 165 105 120 105 90 105 75 90
Circle -16777216 true false 243 127 24
Line -16777216 false 167 229 170 223
Polygon -7500403 true true 75 240 60 255 45 300 30 240 30 75 60 60 75 90
Polygon -2674135 true false 30 135 15 120 0 120 0 135 15 135 30 150
Polygon -2674135 true false 165 210 225 270 210 300 180 285 165 300 150 300 135 300 150 270 135 255 120 270 105 270 135 240
Polygon -2674135 true false 30 210 15 195 0 195 0 210 15 210 30 225
Line -16777216 false 280 153 265 123

elderly
false
3
Polygon -6459832 true true 199 93 237 183 222 177 169 108
Circle -6459832 true true 110 20 80
Polygon -16777216 true false 107 91 122 196 92 301 107 301 137 301 152 226 167 301 197 301 212 301 182 196 197 91
Rectangle -7500403 true false 135 75 172 94
Polygon -7500403 true false 105 60 195 60 180 120 135 120 105 60
Polygon -7500403 true false 119 45 104 45 194 45 179 15 119 15 104 45
Polygon -1 true false 120 45 105 75 105 45
Circle -16777216 true false 149 43 12
Circle -16777216 true false 152 46 6
Circle -16777216 true false 172 42 12
Polygon -6459832 true true 149 72 183 72 167 88 149 89 137 71 152 71
Line -2064490 false 147 76 171 78
Polygon -6459832 true true 105 90 67 180 82 174 135 105
Circle -7500403 false false 132 90 16
Circle -7500403 false false 138 94 16
Circle -7500403 false false 150 95 16
Circle -7500403 false false 161 21 16
Circle -7500403 false false 154 20 10
Polygon -13791810 true false 123 195 183 195 212 300 169 300 152 224 138 299 92 300
Polygon -7500403 true false 254 198 250 188 242 185 237 181 230 183 229 198 226 214 227 224 228 241 230 257 230 275 228 290 233 298 241 295 241 289 240 272 237 245 237 226 239 212 239 200 239 194 241 194 248 196 250 203 256 207 257 204

essay
false
0
Rectangle -7500403 true true 75 30 225 270

factory
false
0
Rectangle -7500403 true true 76 194 285 270
Rectangle -7500403 true true 36 95 59 231
Rectangle -16777216 true false 90 210 270 240
Line -7500403 true 90 195 90 255
Line -7500403 true 120 195 120 255
Line -7500403 true 150 195 150 240
Line -7500403 true 180 195 180 255
Line -7500403 true 210 210 210 240
Line -7500403 true 240 210 240 240
Line -7500403 true 90 225 270 225
Circle -1 true false 37 73 32
Circle -1 true false 55 38 54
Circle -1 true false 96 21 42
Circle -1 true false 105 40 32
Circle -1 true false 129 19 42
Rectangle -7500403 true true 14 228 78 270

fireball
true
0
Polygon -7500403 true true 151 14 134 18 103 18 59 52 40 90 32 143 37 192 68 154 71 191 83 228 111 273 127 245 148 289 167 259 180 188 195 243 217 209 226 174 227 97 256 144 256 99 238 37 213 22 183 19
Polygon -955883 true false 126 16 91 49 85 88 91 132 103 168 118 147 125 119 135 159 151 204 185 139 195 97 193 47 164 14
Polygon -2674135 true false 155 16 172 32 172 57 162 76 148 99 130 67 131 40 135 18

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

fly 
false
0
Polygon -1 true false 0 150 15 180 60 210 120 225 180 225 240 210 285 180 300 150 300 135 285 120 240 105 195 105 150 105 105 105 60 105 15 120 0 135
Polygon -16777216 false false 105 105 60 105 15 120 0 135 0 150 15 180 60 210 120 225 180 225 240 210 285 180 300 150 300 135 285 120 240 105 210 105
Polygon -7500403 true true 60 131 90 161 135 176 165 176 210 161 240 131 225 101 195 71 150 60 105 71 75 101
Circle -16777216 false false 255 135 30
Circle -16777216 false false 180 180 30
Circle -16777216 false false 90 180 30
Circle -16777216 false false 15 135 30
Circle -7500403 true true 15 135 30
Circle -7500403 true true 90 180 30
Circle -7500403 true true 180 180 30
Circle -7500403 true true 255 135 30
Polygon -16777216 false false 150 59 105 70 75 100 60 130 90 160 135 175 165 175 210 160 240 130 225 100 195 70

general
false
0
Rectangle -2064490 true false 127 79 172 94
Polygon -10899396 true false 105 90 60 195 90 210 135 105
Polygon -10899396 true false 195 90 240 195 210 210 165 105
Circle -2064490 true false 110 5 80
Polygon -10899396 true false 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -6459832 true false 120 193 180 201
Polygon -7500403 true true 122 4 107 16 102 39 105 53 148 34 192 27 189 17 172 2 145 0
Polygon -16777216 true false 183 90 240 15 247 22 193 90
Rectangle -6459832 true false 114 187 128 208
Rectangle -6459832 true false 177 187 191 208
Circle -1184463 true false 169 108 8
Circle -1184463 true false 157 107 8
Circle -1184463 true false 169 119 8
Circle -1184463 true false 158 119 8
Rectangle -2674135 true false 156 102 178 107
Rectangle -13345367 true false 155 97 177 102
Rectangle -1184463 true false 156 93 178 98
Polygon -1184463 true false 140 2 132 33 152 10 128 11 152 30

glitch
false
0
Rectangle -2674135 true false 75 60 90 90
Rectangle -13791810 true false 120 60 165 150
Rectangle -13840069 true false 150 150 195 165
Rectangle -6459832 true false 30 195 150 240
Rectangle -14835848 true false 105 135 135 195
Rectangle -7500403 true true 60 180 120 210
Rectangle -8630108 true false 195 105 240 300

homeless
false
3
Polygon -6459832 true true 199 93 237 183 222 177 169 108
Circle -6459832 true true 110 20 80
Polygon -7500403 true false 107 91 122 196 92 301 107 301 137 301 152 226 167 301 197 301 212 301 182 196 197 91
Rectangle -7500403 true false 135 75 172 94
Polygon -16777216 true false 105 60 195 60 180 120 135 120 105 60
Polygon -16777216 true false 119 45 104 45 194 45 179 15 119 15 104 45
Polygon -16777216 true false 120 45 105 75 105 45
Circle -16777216 true false 149 43 12
Circle -16777216 true false 152 46 6
Circle -16777216 true false 172 42 12
Polygon -6459832 true true 149 72 183 72 167 88 149 89 137 71 152 71
Line -2064490 false 147 76 171 78
Polygon -6459832 true true 105 90 67 180 82 174 135 105
Circle -7500403 false false 132 90 16
Circle -7500403 false false 138 94 16
Circle -7500403 false false 150 95 16
Circle -7500403 false false 161 21 16
Circle -7500403 false false 154 20 10
Polygon -10899396 true false 239 169 247 177 238 180 229 199 220 186 235 176
Polygon -6459832 true true 166 168 186 167 185 176 182 184 174 193 162 205 148 200 147 188 160 183
Polygon -13791810 true false 123 195 183 195 212 300 169 300 152 224 138 299 92 300
Circle -13345367 true false 149 217 12
Circle -13345367 true false 140 214 12
Circle -13345367 true false 148 222 12
Circle -13345367 true false 150 227 12
Circle -6459832 true true 182 261 10
Circle -6459832 true true 116 216 16

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

juice
false
0
Rectangle -7500403 true true 105 75 180 75
Rectangle -1184463 true false 102 71 199 264
Polygon -1184463 true false 201 72 236 60 238 255
Polygon -1184463 true false 239 248 196 265 199 65
Line -16777216 false 198 71 200 263
Line -16777216 false 104 72 104 264
Polygon -1184463 true false 233 61 126 61 105 73 203 72
Line -16777216 false 234 62 200 74
Line -16777216 false 125 61 103 73
Line -16777216 false 105 74 200 74
Line -16777216 false 112 129 133 129
Line -16777216 false 124 145 124 130
Line -16777216 false 125 144 117 144
Line -16777216 false 118 143 118 138
Line -16777216 false 139 129 139 145
Line -16777216 false 149 129 149 145
Line -16777216 false 139 147 150 147
Line -16777216 false 159 128 159 144
Line -16777216 false 174 129 165 129
Line -16777216 false 166 130 166 144
Line -16777216 false 175 144 167 144
Line -16777216 false 181 128 191 128
Line -16777216 false 181 129 181 144
Line -16777216 false 182 144 193 144
Line -16777216 false 182 137 191 137
Circle -955883 true false 128 171 54
Rectangle -1 true false 147 20 156 69
Rectangle -1 true false 99 21 152 27

knight
false
13
Polygon -7500403 true false 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Polygon -7500403 true false 105 90 60 195 90 210 135 105
Polygon -7500403 true false 195 90 240 195 210 210 165 105
Circle -7500403 true false 110 5 80
Rectangle -7500403 true false 127 79 172 94
Polygon -7500403 true false 105 90 60 195 90 210 114 156 120 195 90 270 210 270 180 195 186 155 210 210 240 195 195 90 165 90 150 150 135 90
Line -16777216 false 196 90 151 149
Line -16777216 false 180 195 151 151
Circle -2674135 true false 91 -16 38
Line -16777216 false 104 90 149 149
Line -16777216 false 120 195 149 151
Polygon -1 true false 170 11 140 35 186 63 189 39 180 19
Circle -16777216 true false 164 19 13
Line -16777216 false 141 35 111 44
Line -16777216 false 127 78 174 77
Line -16777216 false 127 91 174 90
Rectangle -16777216 true false 225 128 235 226
Polygon -1184463 true false 232 35 218 64 218 123 210 135 252 134 243 123 244 64 233 37

medusa
false
0
Polygon -10899396 true false 165 212 174 230 205 227 240 257 270 302 255 257 215 215 169 217
Polygon -10899396 true false 135 212 126 230 95 227 60 257 30 302 45 257 85 215 131 217
Polygon -10899396 true false 165 81 135 81 90 165 210 165 165 81
Polygon -14835848 true false 150 19 120 30 120 45 130 66 144 81 127 96 129 113 144 134 136 185 121 195 114 217 120 255 135 270 165 270 180 255 188 218 181 195 165 184 157 134 170 115 173 95 156 81 171 66 181 42 180 30
Polygon -14835848 true false 165 17 174 35 205 32 240 62 270 107 255 62 215 20 169 22
Polygon -10899396 true false 176 62 216 45 252 44 296 77 260 35 217 32 173 49
Polygon -13840069 true false 170 45 200 60 245 75 290 105 248 65 216 56 170 30
Line -7500403 true 120 36 75 45
Line -7500403 true 75 45 90 15
Line -7500403 true 180 35 225 45
Line -7500403 true 225 45 210 15
Polygon -13840069 true false 130 45 100 60 55 75 10 105 52 65 84 56 130 30
Polygon -14835848 true false 124 62 84 45 48 44 4 77 40 35 83 32 127 49
Polygon -10899396 true false 135 17 126 35 95 32 60 62 30 107 45 62 85 20 131 22
Circle -2674135 true false 133 35 12
Circle -2674135 true false 152 36 12
Circle -2674135 true false 138 53 20

meteor impact
false
0
Circle -7500403 true true 75 75 150
Polygon -7500403 true true 300 150 240 120 240 180
Polygon -7500403 true true 150 0 120 60 180 60
Polygon -7500403 true true 150 300 120 240 180 240
Polygon -7500403 true true 0 150 60 120 60 180
Polygon -7500403 true true 60 195 105 240 45 255
Polygon -7500403 true true 60 105 105 60 45 45
Polygon -7500403 true true 195 60 240 105 255 45
Polygon -7500403 true true 240 195 195 240 255 255

meteor location
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

minotaur
false
0
Circle -7500403 true true 75 75 150
Circle -16777216 false false 75 75 150
Polygon -7500403 true true 150 15 90 30 75 60 90 120 120 180 180 180 210 120 225 60 210 30
Polygon -16777216 true false 150 60 105 90 105 60
Polygon -16777216 true false 150 60 195 90 195 60
Polygon -16777216 true false 120 180 135 165 150 180 165 165 180 180
Polygon -7500403 true true 225 60 248 53 263 36 272 12 272 -11 265 -37 258 -52 246 -65 231 -75 212 -82 226 -64 238 -44 243 -22 242 6 231 26 214 36
Polygon -7500403 true true 75 60 52 53 37 36 28 12 28 -11 35 -37 42 -52 54 -65 69 -75 88 -82 74 -64 62 -44 57 -22 58 6 69 26 86 36
Line -16777216 false 195 75 210 30
Line -16777216 false 105 75 90 30
Polygon -16777216 false false 152 14 91 29 75 57 90 122 120 180 181 180 209 121 225 60 211 31
Rectangle -7500403 true true 165 210 195 300
Rectangle -16777216 false false 165 210 195 300
Rectangle -7500403 true true 105 210 135 300
Rectangle -16777216 false false 105 210 135 300

neanderthal
false
13
Circle -6459832 true false 110 20 80
Polygon -6459832 true false 108 89 123 194 93 299 108 299 138 299 153 224 168 299 198 299 213 299 183 194 198 89
Rectangle -7500403 true false 135 75 172 94
Polygon -6459832 true false 195 90 254 157 225 180 165 105
Polygon -6459832 true false 105 90 45 154 75 180 135 105
Polygon -16777216 true false 105 60 195 60 180 120 135 120 105 60
Line -6459832 false 150 225 165 225
Polygon -16777216 true false 120 45 105 45 195 45 180 15 120 15 105 45
Polygon -16777216 true false 120 45 105 75 105 45
Circle -16777216 true false 149 43 12
Circle -16777216 true false 152 46 6
Circle -16777216 true false 172 42 12
Polygon -10899396 true false 145 203 137 221 145 221 143 237 150 233 152 246 156 234 159 236 155 226 154 222 170 225 153 204 149 198 146 206
Polygon -6459832 true false 149 72 183 72 167 88 149 89 137 71 152 71
Line -2064490 true 147 76 171 78
Rectangle -955883 true false 225 75 240 285
Polygon -16777216 true false 217 77 232 36 247 77

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

pterodactyl
true
0
Polygon -7500403 true true 150 75 165 75
Polygon -7500403 true true 133 91 148 16 163 91 138 117 163 121 208 91 298 151 238 136 208 136 163 181 178 211 163 226 178 241 163 241 163 226 163 196 148 181 148 196 148 181 133 196 133 241 118 241 133 226 118 211 133 181 88 136 58 136 -2 151 103 91 133 121 158 118 133 91
Circle -7500403 true true 125 113 50
Circle -7500403 true true 139 96 16
Rectangle -7500403 true true 140 89 155 115
Rectangle -7500403 true true 127 218 134 232
Rectangle -7500403 true true 163 219 167 237

rat
false
0
Polygon -7500403 true true 38 162 24 165 19 174 22 192 47 213 90 225 135 230 161 240 178 262 150 246 117 238 73 232 36 220 11 196 7 171 15 153 37 146 46 145
Polygon -7500403 true true 289 142 271 165 237 164 217 185 235 192 254 192 259 199 245 200 248 203 226 199 200 194 155 195 122 185 84 187 91 195 82 192 83 201 72 190 67 199 62 185 46 183 36 165 40 134 57 115 74 106 60 109 90 97 112 94 92 93 130 86 154 88 134 81 183 90 197 94 183 86 212 95 211 88 224 83 235 88 248 97 246 90 257 107 255 97 270 120
Polygon -16777216 true false 234 100 220 96 210 100 214 111 228 116 239 115
Circle -16777216 true false 246 117 20
Line -7500403 true 270 153 282 174
Line -7500403 true 272 153 255 173
Line -7500403 true 269 156 268 177

robot
false
0
Polygon -7500403 true true 122 162 105 285 137 252 167 252 198 284 182 162
Polygon -1 true false 135 285 105 135 105 105 120 45 136 29 151 28 164 28 180 45 195 105 195 135 165 285
Rectangle -7500403 true true 147 176 153 288
Line -7500403 true 105 105 135 120
Line -7500403 true 135 120 165 120
Line -7500403 true 165 120 195 105
Line -7500403 true 105 135 135 150
Line -7500403 true 135 150 165 150
Line -7500403 true 165 150 195 135
Line -7500403 true 127 64 147 80
Line -7500403 true 170 66 156 81
Circle -7500403 true true 122 67 15
Circle -7500403 true true 162 67 13
Polygon -7500403 true true 106 135 60 109 45 131 49 144 64 187 75 138 107 147
Polygon -7500403 true true 196 132 242 106 257 128 253 141 238 184 227 135 195 144
Polygon -7500403 true true 133 23 217 35 122 39

rocket
true
0
Polygon -7500403 true true 120 165 75 285 135 255 165 255 225 285 180 165
Polygon -1 true false 135 285 105 135 105 105 120 45 135 15 150 0 165 15 180 45 195 105 195 135 165 285
Rectangle -7500403 true true 147 176 153 288
Polygon -7500403 true true 120 45 180 45 165 15 150 0 135 15
Line -7500403 true 105 105 135 120
Line -7500403 true 135 120 165 120
Line -7500403 true 165 120 195 105
Line -7500403 true 105 135 135 150
Line -7500403 true 135 150 165 150
Line -7500403 true 165 150 195 135

skateboarder
false
0
Circle -7500403 true true 102 -23 80
Rectangle -7500403 true true 120 49 165 64
Rectangle -13840069 true false 54 268 264 283
Line -16777216 false 135 165 165 165
Line -16777216 false 135 135 165 135
Line -16777216 false 90 135 120 135
Line -16777216 false 105 120 120 120
Line -16777216 false 180 120 195 120
Line -16777216 false 180 135 210 135
Line -16777216 false 90 150 105 165
Line -16777216 false 225 165 210 180
Line -16777216 false 75 165 90 180
Line -16777216 false 210 150 195 165
Line -16777216 false 180 105 210 180
Line -16777216 false 120 105 90 180
Line -16777216 false 150 135 150 165
Polygon -13840069 true false 98 5 102 19 188 -2 192 -17 171 -15 164 -24 136 -26 109 -22 99 -10
Polygon -7500403 true true 101 61 116 166 86 256 101 271 131 271 146 196 161 271 191 271 206 256 176 166 191 61
Polygon -2674135 true false 56 165 86 180 110 124 116 165 176 165 183 127 206 180 236 165 191 60 161 60 146 75 146 104 131 60 101 60
Polygon -13345367 true false 176 165 116 165 86 255 101 270 131 270 146 195 161 270 191 270 206 255
Circle -16777216 true false 235 275 27
Circle -16777216 true false 53 275 27

spartan
false
13
Rectangle -955883 true false 225 60 240 255
Circle -6459832 true false 110 20 80
Polygon -6459832 true false 108 89 123 194 93 299 108 299 138 299 153 224 168 299 198 299 213 299 183 194 198 89
Rectangle -7500403 true false 135 75 172 94
Polygon -6459832 true false 195 90 254 157 225 180 165 105
Polygon -6459832 true false 105 90 45 154 75 180 135 105
Polygon -16777216 true false 105 60 195 60 178 96 127 94 105 60
Polygon -1184463 true false 120 45 105 45 195 45 180 15 120 15 105 45
Polygon -1184463 true false 120 45 105 75 105 45
Circle -16777216 true false 149 43 12
Circle -16777216 true false 152 46 6
Circle -16777216 true false 172 42 12
Polygon -6459832 true false 149 72 183 72 167 88 149 89 137 71 152 71
Line -16777216 false 147 76 171 78
Polygon -16777216 true false 219 60 232 14 245 61 220 60
Polygon -1184463 true false 105 90 120 90 150 135 180 135 195 90 195 150 180 195 120 195 105 120 105 90
Circle -955883 true false -4 101 127
Circle -16777216 false false 131 93 14
Circle -16777216 false false 149 100 10
Circle -16777216 false false 165 91 13
Circle -16777216 false false 167 104 13
Circle -16777216 false false 153 113 10
Polygon -955883 true false 120 195 180 195 210 255 90 255 120 195
Circle -16777216 false false 6 111 108
Circle -1184463 true false 18 123 85
Circle -2674135 true false 39 144 42

st tiger
false
0
Polygon -1 true false 257 130 272 127 282 133 293 146 293 157 290 165 287 164 287 153 287 144 284 141 276 137 267 136 256 133
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -955883 true false 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -955883 true false -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113
Circle -16777216 true false 59 141 10
Circle -16777216 true false 108 169 7
Circle -16777216 true false 102 139 9
Circle -16777216 true false 128 154 11
Circle -16777216 true false 71 162 8
Circle -16777216 true false 168 139 12
Circle -16777216 true false 149 135 9
Circle -16777216 true false 196 123 12

store
false
0
Rectangle -7500403 true true 30 45 45 240
Rectangle -16777216 false false 30 45 45 165
Rectangle -7500403 true true 15 165 285 255
Rectangle -16777216 true false 120 195 180 255
Line -7500403 true 150 195 150 255
Rectangle -16777216 true false 30 180 105 240
Rectangle -16777216 true false 195 180 270 240
Line -16777216 false 0 165 300 165
Polygon -7500403 true true 0 165 45 135 60 90 240 90 255 135 300 165
Rectangle -7500403 true true 0 0 75 45
Rectangle -16777216 false false 0 0 75 45

student
false
0
Polygon -13791810 true false 135 90 150 105 135 165 150 180 165 165 150 105 165 90
Polygon -2674135 true false 195 90 240 195 210 210 165 105
Circle -7500403 true true 110 5 80
Rectangle -7500403 true true 127 79 172 94
Polygon -955883 true false 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Polygon -1 true false 100 210 130 225 145 165 85 135 63 189
Polygon -13791810 true false 90 210 120 225 135 165 67 130 53 189
Polygon -1 true false 120 224 131 225 124 210
Line -16777216 false 139 168 126 225
Line -16777216 false 140 167 76 136
Polygon -2674135 true false 105 90 60 195 90 210 135 105
Polygon -11221820 true false 166 300 216 302 180 191 139 193 130 228 115 223 112 222 79 300 104 301 138 301 149 226
Circle -16777216 true false 151 25 10
Circle -16777216 true false 174 25 10
Line -16777216 false 153 52 181 59
Circle -6459832 true false 113 13 17
Circle -6459832 true false 124 8 17
Circle -6459832 true false 135 4 17
Circle -6459832 true false 145 4 17
Circle -6459832 true false 156 5 17
Circle -6459832 true false 162 6 17
Circle -6459832 true false 110 23 17
Circle -6459832 true false 121 21 17
Circle -6459832 true false 128 18 17
Circle -6459832 true false 105 32 17

survivor
false
0
Rectangle -7500403 true true 127 79 172 94
Polygon -16777216 true false 195 90 240 195 210 210 165 105
Circle -7500403 true true 110 5 80
Polygon -6459832 true false 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Polygon -16777216 true false 121 90 106 90 181 195 181 165
Line -16777216 false 109 105 139 105
Line -16777216 false 122 125 151 117
Line -16777216 false 138 143 160 134
Line -16777216 false 158 179 181 158
Line -16777216 false 146 160 169 146
Rectangle -16777216 true false 120 193 180 201
Polygon -16777216 true false 122 86 107 74 102 51 105 37 148 56 192 63 189 73 172 88 145 90
Rectangle -16777216 true false 114 187 128 208
Rectangle -16777216 true false 177 187 191 208
Polygon -16777216 true false 122 4 107 16 102 39 105 53 148 34 192 27 189 17 172 2 145 0
Circle -16777216 true false 166 31 13
Polygon -16777216 true false 105 90 60 195 90 210 135 105

t-rex
true
0
Polygon -7500403 true true 75 210 75 240 105 240 150 225 165 225 195 240 240 255 255 240 285 240 300 210 300 180 285 165 270 60 255 45 240 45 225 60 210 75 210 120 180 90 135 75 120 75 75 90
Circle -16777216 true false 243 142 24
Line -16777216 false 281 197 270 192
Line -16777216 false 274 220 266 212
Line -16777216 false 262 239 257 230
Line -16777216 false 240 251 240 236
Line -16777216 false 215 247 217 233
Line -16777216 false 189 237 192 231
Line -16777216 false 167 229 170 223
Polygon -7500403 true true 75 240 60 255 45 300 30 240 30 75 60 60 75 90
Polygon -7500403 true true 30 165 15 150 0 150 0 165 15 165 30 180
Polygon -7500403 true true 30 120 15 105 0 105 0 120 15 120 30 135
Polygon -7500403 true true 165 90 150 75 150 45 165 45 165 75 180 90
Polygon -7500403 true true 135 90 120 75 120 45 135 45 135 75 150 90

tempg
false
14
Circle -1 true false 49 49 201
Circle -16777216 true true 99 99 42
Circle -16777216 true true 159 99 42
Line -16777216 true 105 180 210 195

tempk
false
0
Circle -16777216 true false 49 49 201
Circle -1 true false 99 99 42
Circle -1 true false 159 99 42
Line -1 false 105 180 210 195

terminator
false
0
Polygon -7500403 true true 75 150 90 195 210 195 225 150 255 120 255 45 180 0 120 0 45 45 45 120
Circle -16777216 true false 165 60 60
Circle -16777216 true false 75 60 60
Polygon -7500403 true true 225 195 300 195 285 90 270 105 270 165 180 180
Polygon -7500403 true true 210 210 225 285 195 285 165 165
Polygon -7500403 true true 90 210 75 285 105 285 135 165
Rectangle -7500403 true true 135 165 165 270
Circle -2674135 true false 180 75 30
Circle -2674135 true false 90 75 30
Circle -1 true false 189 82 14
Circle -1 true false 97 82 14
Polygon -7500403 true true 75 195 0 195 15 90 30 105 30 165 120 180
Circle -13345367 true false -4 71 67
Circle -11221820 true false 0 75 60
Line -13345367 false 34 76 26 91
Line -13345367 false 27 88 35 97
Line -13345367 false 18 100 29 111
Line -13345367 false 52 108 27 118
Line -13345367 false 17 86 12 104
Line -13345367 false 26 97 20 110
Line -13345367 false 44 101 37 113
Line -13345367 false 47 91 32 82
Line -13345367 false 12 109 18 124

thug
false
3
Polygon -6459832 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Polygon -7500403 true false 60 196 90 211 114 155 120 196 180 196 195 120 255 135 255 105 195 91 165 91 150 106 150 135 135 91 105 91
Circle -6459832 true true 110 5 80
Rectangle -6459832 true true 127 79 172 94
Polygon -13345367 true false 180 195 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285
Line -16777216 false 135 165 165 165
Line -16777216 false 135 135 165 135
Line -16777216 false 90 135 120 135
Line -16777216 false 105 120 120 120
Line -16777216 false 185 108 198 103
Line -16777216 false 196 114 225 108
Line -16777216 false 90 150 105 165
Line -16777216 false 244 111 229 126
Line -16777216 false 75 165 90 180
Line -16777216 false 234 109 219 124
Line -16777216 false 181 100 240 120
Line -16777216 false 120 105 90 180
Line -16777216 false 150 135 150 165
Polygon -16777216 true false 100 30 104 44 189 24 185 10 173 10 166 1 138 -1 111 3 109 28
Rectangle -16777216 true false 247 88 284 98
Rectangle -16777216 true false 254 95 262 115
Line -16777216 false 258 105 270 96

tower
false
15
Rectangle -7500403 true false 135 60 165 90
Rectangle -7500403 true false 180 60 225 90
Rectangle -7500403 true false 90 255 210 300
Line -16777216 false 75 255 225 255
Rectangle -16777216 false false 90 255 210 300
Polygon -7500403 true false 90 255 105 105 195 105 210 255
Polygon -16777216 false false 90 255 105 105 195 105 210 255
Rectangle -7500403 true false 75 90 120 60
Rectangle -7500403 true false 75 84 225 105
Rectangle -7500403 true false 135 90 165 60
Rectangle -7500403 true false 180 90 225 60
Polygon -16777216 false false 90 105 75 105 75 60 120 60 120 84 135 84 135 60 165 60 165 84 179 84 180 60 225 60 225 105
Rectangle -7500403 true false 75 60 120 90

train passenger car
false
0
Polygon -7500403 true true 15 206 15 150 15 135 30 120 270 120 285 135 285 150 285 206 270 210 30 210
Circle -16777216 true false 240 195 30
Circle -16777216 true false 210 195 30
Circle -16777216 true false 60 195 30
Circle -16777216 true false 30 195 30
Rectangle -16777216 true false 30 140 268 165
Line -7500403 true 60 135 60 165
Line -7500403 true 60 135 60 165
Line -7500403 true 90 135 90 165
Line -7500403 true 120 135 120 165
Line -7500403 true 150 135 150 165
Line -7500403 true 180 135 180 165
Line -7500403 true 210 135 210 165
Line -7500403 true 240 135 240 165
Rectangle -16777216 true false 5 195 19 207
Rectangle -16777216 true false 281 195 295 207
Rectangle -13345367 true false 15 165 285 173
Rectangle -2674135 true false 15 180 285 188

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

tree pine
true
0
Rectangle -6459832 true false 120 225 180 300
Polygon -7500403 true true 150 240 240 270 150 135 60 270
Polygon -7500403 true true 150 75 75 210 150 195 225 210
Polygon -7500403 true true 150 7 90 157 150 142 210 157 150 7

troll
false
0
Rectangle -6459832 true false 127 79 172 94
Polygon -10899396 true false 105 90 60 195 90 210 135 105
Polygon -10899396 true false 195 90 240 195 210 210 165 105
Circle -10899396 true false 110 5 80
Polygon -10899396 true false 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Polygon -6459832 true false 120 90 105 90 180 195 180 165
Line -6459832 false 109 105 139 105
Line -6459832 false 122 125 151 117
Line -6459832 false 137 143 159 134
Line -6459832 false 158 179 181 158
Line -6459832 false 146 160 169 146
Rectangle -6459832 true false 120 193 180 201
Polygon -16777216 true false 183 90 240 15 247 22 193 90
Rectangle -6459832 true false 116 187 130 208
Rectangle -6459832 true false 177 187 191 208
Circle -955883 true false 163 25 11
Circle -955883 true false 126 25 11
Polygon -955883 true false 153 30 162 44 164 58 162 73 155 71 154 60 141 56 147 47 147 40 153 31
Polygon -6459832 true false 121 198 122 192 125 230 143 224 148 248 166 243 166 229 175 218 181 196
Polygon -16777216 true false 173 14 158 25 158 31 174 23
Polygon -16777216 true false 127 14 142 25 142 31 126 23

ufo side
false
0
Polygon -1 true false 0 150 15 180 60 210 120 225 180 225 240 210 285 180 300 150 300 135 285 120 240 105 195 105 150 105 105 105 60 105 15 120 0 135
Polygon -16777216 false false 105 105 60 105 15 120 0 135 0 150 15 180 60 210 120 225 180 225 240 210 285 180 300 150 300 135 285 120 240 105 210 105
Polygon -7500403 true true 60 131 90 161 135 176 165 176 210 161 240 131 225 101 195 71 150 60 105 71 75 101
Circle -16777216 false false 255 135 30
Circle -16777216 false false 180 180 30
Circle -16777216 false false 90 180 30
Circle -16777216 false false 15 135 30
Circle -7500403 true true 15 135 30
Circle -7500403 true true 90 180 30
Circle -7500403 true true 180 180 30
Circle -7500403 true true 255 135 30
Polygon -16777216 false false 150 59 105 70 75 100 60 130 90 160 135 175 165 175 210 160 240 130 225 100 195 70

viking
false
0
Rectangle -1 true false 123 76 176 95
Polygon -6459832 true false 105 90 60 195 90 210 115 162 184 163 210 210 240 195 195 90
Polygon -6459832 true false 180 195 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285
Circle -1 true false 110 5 80
Line -16777216 false 148 143 150 196
Rectangle -16777216 true false 116 186 182 198
Circle -1 true false 152 143 9
Circle -1 true false 152 166 9
Rectangle -16777216 true false 179 164 183 186
Polygon -955883 true false 180 90 195 90 195 165 195 195 150 195 150 120 180 90
Polygon -10899396 true false 120 90 105 90 105 165 105 195 150 195 150 120 120 90
Polygon -1184463 true false 54 253 54 238 219 73 227 78
Polygon -1184463 true false 266 33 288 61 251 93 243 101 206 63 194 52 244 11
Rectangle -2674135 true false 107 56 107 63
Polygon -2674135 true false 112 52 117 69 118 70 119 71 120 75 121 79 121 81 121 85 128 88 131 89 140 90 145 93 148 97 149 98 156 99 165 96 169 96 173 96 176 94 177 88 178 82 179 80 183 75 186 69 187 63 186 62 185 61 183 58 181 56 179 55 170 55 166 55 160 56 152 56 146 56 141 54 133 53 124 53 120 53 115 54 112 55 110 52
Circle -16777216 true false 162 24 10
Circle -16777216 true false 128 24 10
Line -16777216 false 128 60 170 62

wave
false
0
Polygon -1184463 true false 120 135 90 195 135 195 105 300 225 165 180 165 210 105 165 105 195 0 75 135

well
false
10
Polygon -14835848 true false 150 55 180 60 210 75 240 45 210 45 195 30 165 15 135 15 105 30 90 45 60 45 90 75 120 60
Polygon -14835848 true false 55 150 60 120 75 90 45 60 45 90 30 105 15 135 15 165 30 195 45 210 45 240 75 210 60 180
Polygon -14835848 true false 245 150 240 120 225 90 255 60 255 90 270 105 285 135 285 165 270 195 255 210 255 240 225 210 240 180
Polygon -14835848 true false 150 245 180 240 210 225 240 255 210 255 195 270 165 285 135 285 105 270 90 255 60 255 90 225 120 240
Circle -6459832 true false 60 60 180
Circle -13345367 false true 75 75 150
Circle -13345367 true true 74 74 153

worker
false
13
Polygon -1 true false 124 91 150 165 178 91
Polygon -1 true false 134 91 149 106 134 181 149 196 164 181 149 106 164 91
Polygon -6459832 true false 180 195 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285
Polygon -6459832 true false 120 90 105 90 60 195 90 210 116 158 120 195 180 195 184 158 210 210 240 195 195 90 180 90 165 105 150 165 135 105 120 90
Rectangle -2064490 true true 123 76 176 92
Circle -2064490 true true 110 5 80
Polygon -6459832 true false 150 26 110 41 97 29 137 -1 158 6 185 0 201 6 196 23 204 34 180 33
Line -13345367 false 121 90 194 90
Line -16777216 false 120 195 180 195
Circle -16777216 true false 156 38 8
Circle -16777216 true false 175 38 8
Line -16777216 false 151 57 182 58

zombie
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105
Circle -2674135 true false 127 33 13
Circle -2674135 true false 159 33 13
Polygon -2674135 true false 173 104 158 129 157 146 149 154 156 162
Polygon -2674135 true false 113 110 133 125 137 112 123 102 136 102 150 108 149 118 142 134 133 138 121 135 109 123 100 117 117 114 117 109
Polygon -10899396 true false 180 114 191 126 186 131 181 136 180 142 178 147 177 142
Polygon -2674135 true false 140 63 166 61 157 70 140 65
Polygon -955883 true false 135 192 158 200 156 187 144 185 151 181 172 186 171 211 162 215 142 212 131 208 131 199 131 185 133 170 135 193
Polygon -1 true false 199 118 224 143 225 150 225 156
Polygon -1 true false 101 120 76 145 75 152 75 158

@#$#@#$#@
NetLogo 5.0.4
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 1.0 0.0
0.0 1 1.0 0.0
0.2 0 1.0 0.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180

@#$#@#$#@
0
@#$#@#$#@
