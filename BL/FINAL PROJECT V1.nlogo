globals [disable status score selected1 selected2 name highscore currscore holypatch]

turtles-own[
  top-neighbors
  bottom-neighbors
  left-neighbors
  right-neighbors
  side-matching-neighbors
  vertical-matching-neighbors 
  to-be-destroyed?
  turtcolor
  neighbor
  to-be-changed?
  pine-bypass
]

patches-own[
  tempcolor
  patch-reset
  nextcolor
]

to inital-question ;pre-game setup. Asks the user for basic information
  set name user-input "Como te llamas?"
  user-message (word "Hello, " name". Welcome to Compsci Crush Corruption!")
  ifelse user-yes-or-no? "Do you know the rules?"
  [ifelse user-yes-or-no? "Did You Really Read The Rules?"
    [ifelse user-yes-or-no? "Are You sure? .... Okay then...."
      [user-message "AhHA! See, if you had read the rules you would have pressed no. \n GO!! READ THE RULES!!!!!"
    setup]
      [setup]]
    [user-message "Please Read the Rules!"]]
  [user-message "Please Read the Rules!"]
end

to setup ;clears the world, sets up the piece orientations and makes sure that there are no combos at the beginning of the game.
  ca
  setuppieces ;primary code to setup the pieces
  ask patch 0 0 [set pcolor pink
    set patch-reset pink set holypatch self] ;creates the "holy patch" (induces pieces selection mechanism)
  reset-timer
  set score 0
  set status 1 
  ask turtles[ safe-check  safe-check] ;makes sure there are no combos at the beginning. 
end

to Go  ;allows the game to start
  if status = 1[
    ask patches with [pycor = max-pycor]
    [replace] ;replensihes the turtles after some of them die
    if count turtles-at 0 -1 = 0
    [wait .1
      fd 1] ;creates a gravity effect, where all the pieces will move down. 
    
    if count patches with [pcolor = pink] = 0
    [set pcolor patch-reset] ;resets the holy patch
    if count turtles-here > 1 [die]
  ]
  lose    
end




to on-top [ curneigh dist ] ;counts number of same turtles on top
  if count turtles-at 0 dist = 0[ set top-neighbors curneigh stop ]
  ifelse first [color] of turtles-at 0 dist != color[set top-neighbors curneigh][ on-top curneigh + 1 dist + 1 ]
end

to on-topo 
  on-top 0 1
end

to on-bottom [ curneigh dist ] ;counts number of same turtles on bottom
  if count turtles-at 0 (-1 * dist) = 0[ set bottom-neighbors curneigh stop ]
  ifelse first [color] of turtles-at 0 (-1 * dist) != color[set bottom-neighbors curneigh][ on-bottom curneigh + 1 dist + 1 ]
end

to on-bottomo
  on-bottom 0 1
end

to on-left [ curneigh dist ] ;counts number of same turtles on the left
  if count turtles-at (-1 * dist) 0 = 0[ set left-neighbors curneigh stop ]
  ifelse first [color] of turtles-at (-1 * dist) 0 != color[set left-neighbors curneigh][ on-left curneigh + 1 dist + 1 ]
end

to on-lefto
  on-left 0 1
end

to on-right [ curneigh dist ] ;counts number of same turtles on the right
  if count turtles-at dist 0 = 0[ set right-neighbors curneigh stop ]
  ifelse first [color] of turtles-at dist 0 != color[set right-neighbors curneigh][ on-right curneigh + 1 dist + 1 ]
end

to on-righto
  on-right 0 1
end



to count-sides ;adds up the total number of left and right neighbors
  on-lefto
  on-righto
  set side-matching-neighbors left-neighbors + right-neighbors
end

to count-verticals ;adds up the total number of down and up neighbors
  on-topo
  on-bottomo
  set vertical-matching-neighbors top-neighbors + bottom-neighbors
end

to check ;checks for available combos and sets them to be destroyed.
  set side-matching-neighbors 0
  set vertical-matching-neighbors 0
  set top-neighbors 0
  set bottom-neighbors 0
  set left-neighbors 0
  set right-neighbors 0
  count-sides
  count-verticals
  
  if side-matching-neighbors >= 2[
    set to-be-destroyed? true
  ]
  if vertical-matching-neighbors >= 2[
    set to-be-destroyed? true
  ]
  if top-neighbors = 2 and bottom-neighbors = 1 and shape != "ultimate pineapple"[
    set shape "ultimate pineapple"
    set size 2
    set to-be-destroyed? false
    set pine-bypass true
  ]
  if left-neighbors = 2 and right-neighbors = 1 and shape != "ultimate pineapple"[
    set shape "ultimate pineapple"
    set size 2
    set to-be-destroyed? false
    set pine-bypass true
  ] 
  if top-neighbors = 2 and left-neighbors = 1 and right-neighbors = 1
  [set shape "ultimate lime"
    set size 2
    set to-be-destroyed? false]
  
end

to bonus
  ask turtles[check]
  ask turtles[destroy]
end

to safe-check
  set side-matching-neighbors 0
  set vertical-matching-neighbors 0
  set top-neighbors 0
  set bottom-neighbors 0
  set left-neighbors 0
  set right-neighbors 0
  count-sides
  count-verticals
  
  if top-neighbors >= 1 and bottom-neighbors >= 1[
    set to-be-changed? true
  ]
  if left-neighbors >= 1 and right-neighbors >= 1[
    set to-be-changed? true
  ]
  if to-be-changed? = true[ set color one-of filter [? != color] [15 25 45 65 95 115]]
  turtle-shapes
  set to-be-changed? false
end

to destroy  ;tells the turtles set to die to die
  if to-be-destroyed? = true[
    set score score + 10 
  ]
  if pine-bypass = true[ set pine-bypass false] ;creates and effects as a result of a special piece.
  if to-be-destroyed? = true and shape = "ultimate pineapple"[
    ask turtles-at 1 1[die]
    ask turtles-at 1 0[die]
    ask turtles-at 1 -1[die]
    ask turtles-at 0 1[die] 
    ask turtles-at 0 -1[die]
    ask turtles-at -1 1[die] 
    ask turtles-at -1 0[die]
    ask turtles-at -1 -1[die]
    set score score + 100
    die 
    
  ] 
  ifelse to-be-destroyed? = true[ 
    ask turtle who[ die]
    ][stop]
  wait 2  
  check  
  ifelse count turtles with [to-be-destroyed? = true] > 0[
    destroy
  ][stop ]
  
end

to setuppieces ;set the pieces up
  ask patches 
    [sprout 1 [set color one-of [15 25 45 65 95 115]
      set turtcolor color
      set heading 180
      set size 1.1
      set tempcolor turtcolor
      set color one-of filter [? != [tempcolor] of patch-at 0 0] [15 25 45 65 95 115]
      turtle-shapes]]
end

to replace ;replenishes the pieces after some of them die
  if count turtles-here = 0
    [sprout 1 [
      set color one-of filter [? != [tempcolor] of patch-at 0 0] [15 25 45 65 95 115] ;filters out the pieces so that 
                                                                                      ; less combos are created during replacement of pieces
      set turtcolor color
      turtle-shapes
      set heading 180
      set size 1.1
      set tempcolor turtcolor]] 
end

to up 
  ifelse [pycor] of holypatch != max-pycor[
  ifelse disable = 0
  [ask patches[if pcolor = pink and not (patch-at 0 1 = nobody) ;moves the holy patch up
    [set nextcolor black
      set patch-reset black
      ask patch-at 0 1
      [set nextcolor pink
        set patch-reset pink set holypatch self]]]
  ask patches[ set pcolor nextcolor] ]
  [ask patches[if pcolor = pink
    [ask patches at-points [[1 0] [-1 0] [0 -1]] ;selects the second piece above the first piece.
      [set pcolor black] ]]
  ask turtles with [pcolor = pink][setswitchcolor set selected1 self]
  ask turtles with[pcolor = blue][setswitch2 set selected2 self]
  ask turtles with [pcolor = blue][
    move-to neighbor
    ask other turtles-here[ move-to neighbor set pcolor black set disable 0]]
  ask turtles[check]
  ifelse [to-be-destroyed?] of selected1 = true or [to-be-destroyed?] of selected2 = true or [pine-bypass] of selected1 = true or [pine-bypass] of selected2 = true[
    ask turtles[destroy]
  ][ 
  let tempxcor [xcor] of selected1
  let tempycor [ycor] of selected1
  ask selected1[ move-to selected2] ask selected2 [ move-to patch tempxcor tempycor ] ]
  ]][ask patches[deselect]]
  
end

to lefty 
  ifelse [pxcor] of holypatch != min-pxcor[
  ifelse disable = 0
  [ask patches[if pcolor = pink and not (patch-at -1 0 = nobody) ;moves the holy patch left
    [set nextcolor black
      set patch-reset black
      ask patch-at -1 0
      [set nextcolor pink
        set patch-reset pink set holypatch self]]]
  ask patches[set pcolor nextcolor]]
  [ask patches[if pcolor = pink
    [ask patches at-points [[1 0] [0 1] [0 -1]] ;selects the piece left of the first piece
      [set pcolor black] ]]
  ask turtles with [pcolor = pink][setswitchcolor set selected1 self]
  ask turtles with[pcolor = blue][setswitch2 set selected2 self]
  ask turtles with [pcolor = blue][
    move-to neighbor
    ask other turtles-here[ move-to neighbor set pcolor black set disable 0]]
  ask turtles[check]
  ifelse [to-be-destroyed?] of selected1 = true or [to-be-destroyed?] of selected2 = true or [pine-bypass] of selected1 = true or [pine-bypass] of selected2 = true[
    ask turtles[destroy]
  ][  
  let tempxcor [xcor] of selected1
  let tempycor [ycor] of selected1
  ask selected1[ move-to selected2] ask selected2 [ move-to patch tempxcor tempycor ] ]
  ]][ask patches[deselect]]
  
end

to righty
  ifelse [pxcor] of holypatch != max-pxcor[
  ifelse disable = 0
  [ask patches[if pcolor = pink and not (patch-at 1 0 = nobody) ; Moves the holy patch right
    [set nextcolor black                                      
      set patch-reset black                                  
      ask patch-at 1 0 
      [set nextcolor pink
        set patch-reset pink set holypatch self]]]
  ask patches[ set pcolor nextcolor]]
  [ask patches[if pcolor = pink
    [ask patches at-points [[-1 0] [0 1] [0 -1]] ;sets second piece right of the first piece.
      [set pcolor black] ]]
  ask turtles with [pcolor = pink][setswitchcolor set selected1 self]
  ask turtles with[pcolor = blue][setswitch2 set selected2 self]
  ask turtles with [pcolor = blue][
    move-to neighbor
    ask other turtles-here[ move-to neighbor set pcolor black set disable 0]]
  ask turtles[check]
  ifelse [to-be-destroyed?] of selected1 = true or [to-be-destroyed?] of selected2 = true or [pine-bypass] of selected1 = true or [pine-bypass] of selected2 = true[
    ask turtles[destroy]
  ][ 
  let tempxcor [xcor] of selected1
  let tempycor [ycor] of selected1
  ask selected1[ move-to selected2] ask selected2 [ move-to patch tempxcor tempycor ] ]
  ]][ask patches[deselect]]
  
end

to down 
  ifelse [pycor] of holypatch != min-pycor[
  ifelse disable = 0 
  [ask patches[if pcolor = pink and not (patch-at 0 -1 = nobody) ;moves the holy patch down
    [set nextcolor black
      set patch-reset black
      ask patch-at 0 -1
      [set nextcolor pink
        set patch-reset pink set holypatch self]]]
  ask patches[ set pcolor nextcolor]]
  [ask patches[if pcolor = pink
    [ask patches at-points [[1 0] [0 1] [-1 0]] ;selects the piece below the first piece
      [set pcolor black] ]]
  ask turtles with [pcolor = pink][setswitchcolor set selected1 self]
  ask turtles with[pcolor = blue][setswitch2 set selected2 self]
  ask turtles with [pcolor = blue][
    move-to neighbor
    ask other turtles-here[ move-to neighbor set pcolor black set disable 0]]
  ask turtles[check]
  ifelse [to-be-destroyed?] of selected1 = true or [to-be-destroyed?] of selected2 = true or [pine-bypass] of selected1 = true or [pine-bypass] of selected2 = true[
    ask turtles[destroy]
  ][ 
  let tempxcor [xcor] of selected1
  let tempycor [ycor] of selected1
  ask selected1[ move-to selected2] ask selected2 [ move-to patch tempxcor tempycor ] ]
  ]][ask patches[deselect]]
  
end

to selectpieces
  if pcolor = pink
  [set disable true
    ask neighbors4
    [set pcolor blue]]
end

to setswitchcolor ;set the second piece as a variable
  if pcolor = pink
  [set neighbor one-of patches with [pcolor = blue]]
end

to setswitch2 ;sets the first piece as a variable
  if pcolor = blue
  [set neighbor one-of patches with [pcolor = pink]]
end

to deselect ;deselects the holy patch in case a accidental move it made
  if pcolor = pink
  [set disable 0
    ask neighbors4
    [set pcolor black]]
end


to lose ;sets conditions for when you run out of time. 
  if timer < 198 and timer > 200
  [user-message "time's a' wasting"]
  if timer > 215
  [user-message (word "Game Over! \n Your Score is"  score "\n Press Halt.")]
  set currscore score
  if currscore > highscore
  [set highscore currscore]
end


to turtle-shapes ;sets special turtle shapes
  if color = 45
  [set shape "pineapple2"]
  if color = 15
  [set shape "pomegranate"]
  if color = 95
  [set shape "blueberry"]
  if color = 65
  [set shape "lime"]
  if color = 115
  [set shape "figs"]
  if color = 25
  [set shape "tangerine"]
end

;****************************************************************************************************************************************************


  
@#$#@#$#@
GRAPHICS-WINDOW
373
67
828
543
5
5
40.5
1
10
1
1
1
0
0
0
1
-5
5
-5
5
0
0
1
ticks
30.0

BUTTON
12
68
93
103
setup
inital-question
NIL
1
T
OBSERVER
NIL
Y
NIL
NIL
1

BUTTON
160
58
223
91
Play
Go
T
1
T
TURTLE
NIL
G
NIL
NIL
1

BUTTON
106
387
161
420
NIL
up
NIL
1
T
OBSERVER
NIL
I
NIL
NIL
1

BUTTON
43
422
106
455
NIL
lefty\n
NIL
1
T
OBSERVER
NIL
J
NIL
NIL
1

BUTTON
159
421
223
454
NIL
righty
NIL
1
T
OBSERVER
NIL
L
NIL
NIL
1

BUTTON
103
456
166
489
NIL
down
NIL
1
T
OBSERVER
NIL
K
NIL
NIL
1

BUTTON
37
511
137
544
NIL
selectpieces
NIL
1
T
PATCH
NIL
A
NIL
NIL
1

BUTTON
164
509
242
542
NIL
deselect
NIL
1
T
PATCH
NIL
S
NIL
NIL
1

MONITOR
121
301
187
346
NIL
score
17
1
11

TEXTBOX
463
17
904
67
COMPSCI CRUSH CORRUPTION
20
65.0
1

MONITOR
236
298
312
343
NIL
timer
17
1
11

BUTTON
110
123
187
156
NIL
bonus
NIL
1
T
OBSERVER
NIL
D
NIL
NIL
1

MONITOR
14
301
92
346
NIL
highscore
17
1
11

TEXTBOX
17
10
132
54
Press this button to set yourself up for the game
11
0.0
1

TEXTBOX
152
15
247
43
Press This button to Play the Game
11
0.0
1

TEXTBOX
21
121
121
228
A button that gives you a bonus by breaking more combos. A high skilled-required button.
11
0.0
1

TEXTBOX
216
244
366
286
How much time do you have left?\nMax Time: 215
11
0.0
1

TEXTBOX
129
258
188
288
Your Score
11
0.0
1

TEXTBOX
18
259
92
292
The High Score
11
0.0
1

TEXTBOX
246
398
359
477
Here are the master controls.\n(Read info tab to learn how to use them)
11
0.0
1

BUTTON
165
189
286
222
Direct Setup
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

TEXTBOX
220
131
370
191
This lets you skip the questionaire in the beginning and go straight to playing.
11
0.0
1

@#$#@#$#@
## WHAT IS IT?

This is a NetLogo recreation of the popular game Bejeweled....with some variations.


### RULES
1. One of the objectives of the game is to get the highest score as possible. Currently the high score is 5920, set by Ernie Lin.
2. In order to score points, the player has to get more than 2 bits of the same shape and color in a row, at which point all the bits in that row will get destroyed.
3. If a person gets 4 bits in a row, a holy pineapple (also known as a megabyte), appears.
4. The holy pineapple, when match again with the same color, will explode all eight neighbors around it, and itself. 
5. YOU CAN'T SWITCH TWO BITS IF THE OUTCOME DOES NOT RESULT IN THE DESTRUCTION OF A BIT.
6. YOU CAN ONLY SWITCH TWO ADJACENT PIECES. 
7. YOU HAVE 215 SECONDS TO GET AS MANY POINTS AS POSSIBLE. The game ends when 215 seconds has been reached, and your score is displayed.
8. The bonus button allows the player to break a row of pieces of the same color. Using this button may help you get bits that you need to create combos, but in some instances, using this button may prevent you from getting larger combos, such as megabytes. THIS BUTTON TAKES SKILL TO USE.

## HOW TO USE IT
The objective of the game is to score as high as possible by combining the individual pieces into small rows or columns, known as bits. The pink patch is known as the "holy patch" and will allow you to move bits.

Setup- Sets up the world and the pieces.

Direct Setup- Skips the questionaire and leads straight to the game.

Up- Moves the holy patch up / selects the piece above the direction of the selected piece.

Down- Moves the holy patch up / selects the piece below the direction of the selected piece.

Left- Moves the holy patch up / selects the piece left of the direction of the selected piece.

Right- Moves the holy patch right  / selects the piece right of the direction of the selected piece.

Bonus- The special button explained in the rules that must be used with skill.

Play- Starts the game. 

Score- Keeps track of Your Score

Timer- Keeps track of the time

Selectpieces- Highlights the four patches around the holy patch, which then you can use the arrow key functions to switch bits.

Deselect- Unselects the patches.

## HOW IT WORKS

This model uses a combination of turtle and patch interactions. In order to get the turtles to switch their places for example, patches were used to notify the turtle above it that it has been selected for switching. Additionally, sequencing was impertive in governing our model. We had to be sure that each bit moved at the same time, checked its neighbors at the same time, etc. To accomplish this paramount task, we had to use lots of turtles-own variables, and global variables. We also had to use a lot of turtle variables in order to sucessfully create a function that would count the number of turtles in a row that had the same color, and then destroy them all. 

## NETLOGO FEATURES
One of the new codes that was needed to accomplish this model was the commnad "move-to." This simplified our code enormously because now, we didn't have to specify a tuftle's xcor and ycor, or their who number, and then tell them to move. Instead, we could just tell them to move in one big step. 

We also used lists and filter to ask a bit to chose a random color. We needed filter because this allowed us to filter out the colors that the turtle couldn't have, because then at the start of the game, the player would already get points without dong anything.

We used user-message, user-input, and user-yes-no? to create an awesome prequestioner that most games have at the beginning of the game.

##Flaws in the Model

Sadly, we weren't able to ask all the pieces to die immediately after they find that they are in a combination. This only die after you move a piece. Fortunetely however, we were able to incoorperate this flaw by making a seperate button in which a person can use to destoy already exisitng combos. This flaw does bring about an opportunity to score extra poiints though, so using the button takes skill if you want to get as high as a score as possible. 


## CREDITS AND REFERENCES

This project was made by Brandon Lin and Andrew "Ernie" Lin, students of MKS21, taught by Mr. Brown Mykolyk.

pd 6

-Credits to Rina Lubit for helping us fix a bug regarding the borders of the world.


                   	*******COMPSCI CRUSH CORRUPTION*********
Now, when the questionaire says, "Are You sure? .... Okay then..." press NO to start the game. 
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

blueberry
false
0
Circle -7500403 true true 75 75 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

figs
false
0
Polygon -7500403 true true 105 150 135 165
Polygon -7500403 true true 135 75 135 120 120 150 105 180 105 195 105 225 120 255 165 255 180 225 180 195 180 180 165 150 150 120 150 75 135 75

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

lightning
false
0
Polygon -7500403 true true 120 135 90 195 135 195 105 300 225 165 180 165 210 105 165 105 195 0 75 135

lime
true
0
Polygon -7500403 true true 150 105 105 90
Polygon -7500403 true true 150 120 120 120 90 135 75 150 45 180 60 195 105 225 150 240 180 225 210 210 240 180 240 165 195 135 165 120 150 120

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

pineapple2
false
0
Polygon -7500403 true true 120 135 105 150 105 165 105 180 105 195 105 210 120 240 135 255 165 255 180 240 195 210 195 195 195 165 195 150 180 135 165 135 135 135
Polygon -10899396 true false 150 135 105 120 150 120 150 135 195 120 150 120 180 105 150 105 150 120 120 105 150 105 150 120 105 75 135 90 150 120 195 75 165 90 150 120 120 60 150 75 150 105 150 120 180 60 150 75 135 45 150 30 165 45 150 75 180 45
Polygon -10899396 true false 150 75 150 105 165 105 180 60
Polygon -10899396 true false 135 105 150 135 165 105 135 105
Polygon -10899396 true false 165 90 120 45 165 75

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

pomegranate
false
0
Polygon -7500403 true true 135 90 120 105 105 120 90 135 90 150 90 180 105 195 135 210 165 210 195 180 195 135 180 120 165 105 150 90 135 90
Polygon -7500403 true true 120 120 135 105 120 75 135 90 150 60 150 90 150 60 165 90 180 90 165 105 180 135

shape1
true
0
Polygon -7500403 true true 45 90 60 135 90 180 135 225 180 240 225 225 255 180 240 165 210 165 195 180 165 165 150 150 135 120 120 90 120 60 105 45 75 30 60 45 45 75

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

tangerine
false
0
Polygon -7500403 true true 135 90 90 105 60 150 90 210 165 225 195 210 210 195 225 165 225 150 195 105 150 90 120 90

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

ultimate lime
true
0
Polygon -7500403 true true 150 105 105 90
Polygon -7500403 true true 150 120 120 120 90 135 75 150 45 180 60 195 105 225 150 240 180 225 210 210 240 180 240 165 195 135 165 120 150 120
Circle -2674135 true false 90 135 30
Circle -2674135 true false 150 135 30
Circle -13345367 true false 99 174 42

ultimate pineapple
false
0
Polygon -7500403 true true 120 135 105 150 105 165 105 180 105 195 105 210 120 240 135 255 165 255 180 240 195 210 195 195 195 165 195 150 180 135 165 135 135 135
Polygon -10899396 true false 150 135 105 120 150 120 150 135 195 120 150 120 180 105 150 105 150 120 120 105 150 105 150 120 105 75 135 90 150 120 195 75 165 90 150 120 120 60 150 75 150 105 150 120 180 60 150 75 135 45 150 30 165 45 150 75 180 45
Polygon -10899396 true false 150 75 150 105 165 105 180 60
Polygon -10899396 true false 135 105 150 135 165 105 135 105
Polygon -10899396 true false 165 90 120 45 165 75
Circle -2674135 true false 120 180 58
Rectangle -2674135 true false 120 150 135 165
Rectangle -2674135 true false 165 150 180 165

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270

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
