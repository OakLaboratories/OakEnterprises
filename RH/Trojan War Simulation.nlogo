globals [reserve-greeks reserve-trojans]
patches-own [health] 
turtles-own [thealth]
breed [greeks greek]
breed [trojans troyjan] 
breed [hector]
breed [achilles]
breed [horse]


to achaeans 
  if (pxcor = pos) [set pcolor blue]
end 
  
  to trojan
    if (pxcor = troypos) [set pcolor red]
  end 
  
  
  to attacktroy 
    
if not any? greeks with [any? trojans in-radius 1]

    [ask patches with [pcolor = blue] [if (reserve-greeks > 1) [sprout-greeks health]] 
    ask greeks [set thealth 50
 set shape "person" set color blue set heading 90 
   ]]
ask greeks [ifelse ([pcolor] of patch-ahead 1 = red)
     [stop] 
     [ifelse
  ([pcolor] of patch-ahead 1 = brown) [stop]
  [ifelse (count trojans in-radius 1 > 0) [stop]
  [set xcor xcor + 1]]]]

     if any? greeks with [any? trojans in-radius 1] 
   [ask achilles [face one-of trojans fd 2]] 
  
ask greeks [if xcor = 16 [user-message "Troy has fallen. Helen is taken back." ask greeks [stamp die]] ]
ask greeks [if xcor = 16 [die]]
  end 
  
  to attackgreeks
    
    if not any? trojans with [any? greeks in-radius 1]
    [ask patches with [pcolor = red] [if (reserve-trojans > 1)
  [sprout-trojans health]]]
    ask trojans [set thealth 50
 set shape "person" set color red set heading 270
   ]
    ask trojans [ifelse ([pcolor] of patch-ahead 1 = blue)
     [stop] [ifelse (count greeks in-radius 1 > 0) [stop]
       [set xcor xcor - 1]]]
    
    ask achilles [if (count hector in-radius 1 > 0)
     [face one-of hector fd 2]]  
 
  
   if any? trojans with [any? greeks in-radius 1] 
   [ask hector [face one-of greeks fd 2]] 
   
  
  ask trojans [if (count patches with [pcolor = blue] < 1) [user-message "Greeks are defeated." ask trojans [stamp die]]]
  ask trojans [if xcor = pos [die]]
  
  end 
  
    to special
      if (not any? hector) [ask one-of patches with [pcolor = red] [sprout-hector 1]] 
  ask hector [set thealth 1 set shape "person" set color yellow set size 1.5]
  if (count hector = 1 and count achilles = 0) [ask one-of patches with [pcolor = blue] [sprout-achilles 1]]
  ask achilles [set thealth 1 set shape "person" set color grey set size 1.5]
  end 
  
to troy
  if (pxcor > 14) [set pcolor brown]
end 

to beach
  if (pxcor = -14) [set pcolor 29]
end 

to sea
  if (pxcor < -14) [set pcolor sky]
end 

to meadow
  if (pxcor > -15) [set pcolor green]
end 

to sethealth
  ask patches with [pcolor = blue] [set health greekarmy]
  ask patches with [pcolor = red] [set health troyarmy]
  ask patches with [pcolor = brown] [set health walloftroy]
end 

to display-health
  ifelse (show-health? = true) [set plabel health] 
  [set plabel ""]  
end 

to display-thealth
  ifelse (show-health? = true) [set label thealth] 
  [set label ""] 
end 

to horsearound
  if (not any? horse)
  [ask one-of patches with [pcolor = 29] [sprout-horse 1]
  ask horse [set shape "trojan horse" 
    set size 2
    set color brown + 2 
    set heading 90
    set thealth 1
    repeat 31 [
      fd 1
      wait .1
    ]]]
end 
  
  
to destroy

  ask turtles with [thealth > 0] [display-thealth]
  
  ask turtles with [thealth < 1]
   [if breed = trojans [set reserve-trojans reserve-trojans - 1] 
    if breed = greeks [set reserve-greeks reserve-greeks - 1]
    die]
   
  ask patches with [health > 0] [display-health]
  ask patches with [pcolor = red] [if count greeks in-radius 1 > 0 
    [set health health - 10]]
  
  ask patches with [pcolor = brown] [if count horse in-radius 2.5 > 0
      [set health health - 555]]
    ask patches with [pcolor = red] [if count horse in-radius 2.5 > 0
      [set health health - 555]]
  
  ask patches with [health <= 0 and pcolor = brown] [set pcolor black]
  ask patches with [health <= 0 and pcolor = blue] [set pcolor black]
  ask patches with [health <= 0 and pcolor = red] [set pcolor black]
  
  ask patches with [pcolor = brown] [if count greeks in-radius 1 > 0
     [set health health - 25]]
  ask patches with [pcolor = red] [if count greeks in-radius 1 > 0
     [set health health - 1]]
  ask patches with [pcolor = blue] [if count trojans in-radius 1 > 0
    [set health health - 1]]
     ask patches with [pcolor = blue] [if count hector in-radius 1 > 0
    [set health health - 5]]
    ask patches with [pcolor = red] [if count greeks in-radius 1 > 0
     [set health health - 5]]

    
  if (mouse-down?) [ask patch mouse-xcor mouse-ycor
    [set pcolor black]]
  if (mouse-down?) [ask patch mouse-xcor mouse-ycor 
    [ask turtles-here 
    [if breed = trojans [set reserve-trojans reserve-trojans - 1] 
    if breed = greeks [set reserve-greeks reserve-greeks - 1]
    die]]]
  
 ask greeks [if count trojans in-radius 1 > 0 
   [ask one-of trojans in-radius 1 [set thealth thealth - 5]]]
   ask trojans [if count greeks in-radius 1 > 0 
     [ask one-of greeks in-radius 1 [set thealth thealth - 5]]]   
   ask hector [if count greeks in-radius 1 > 0 
     [ask one-of greeks in-radius 1 [set thealth thealth - 50]]] 
   ask achilles [if count trojans in-radius 1 > 0 
   [ask one-of trojans in-radius 1 [set thealth thealth - 50]]]
   ask achilles [if count hector in-radius 4 > 0
     [face one-of hector fd 2]]  
  ask achilles [if count hector in-radius 1 > 0
    [ask one-of hector [set thealth thealth - 1]]]
  ask horse [if xcor = 16 [user-message "Troy has fallen. Helen is taken back." ask horse [stamp die]]]

end 




to setup
ca
ask patches [meadow]
ask patches [sea]
ask patches [troy]
ask patches [beach]
ask patches [achaeans]
ask patches [trojan]
sethealth
set reserve-greeks 12000
set reserve-trojans 15000
end 
@#$#@#$#@
GRAPHICS-WINDOW
210
10
649
184
16
5
13.0
1
10
1
1
1
0
0
0
1
-16
16
-5
5
0
0
1
ticks
30.0

SLIDER
37
48
209
81
pos
pos
-13
-2
-13
1
1
NIL
HORIZONTAL

BUTTON
46
142
186
175
Setup
setup
NIL
1
T
OBSERVER
NIL
S
NIL
NIL
1

BUTTON
106
315
209
348
Attack Troy
attacktroy
NIL
1
T
OBSERVER
NIL
A
NIL
NIL
1

SLIDER
649
51
821
84
troypos
troypos
2
14
14
1
1
NIL
HORIZONTAL

BUTTON
649
316
759
349
Defend Troy
attackgreeks
NIL
1
T
OBSERVER
NIL
D
NIL
NIL
1

SLIDER
649
10
821
43
troyarmy
troyarmy
0
15
5
1
1
NIL
HORIZONTAL

SLIDER
37
10
209
43
greekarmy
greekarmy
0
15
5
1
1
NIL
HORIZONTAL

SLIDER
649
92
821
125
walloftroy
walloftroy
0
500
500
1
1
NIL
HORIZONTAL

SWITCH
47
179
187
212
show-health?
show-health?
1
1
-1000

BUTTON
47
215
187
293
Run
destroy\n
T
1
T
OBSERVER
NIL
R
NIL
NIL
1

MONITOR
57
370
210
415
Greek Soldiers
turtles with [breed = greeks]
17
1
11

MONITOR
649
370
802
415
Trojan Soldiers
turtles with [breed = trojans]
17
1
11

MONITOR
86
426
210
471
Remaining Greeks
reserve-greeks
17
1
11

MONITOR
648
425
776
470
Remaining Trojans
reserve-trojans
17
1
11

BUTTON
25
90
206
123
Deploy the Trojan Horse
horsearound
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
675
167
802
200
Special Soldiers
special
NIL
1
T
OBSERVER
NIL
W
NIL
NIL
1

@#$#@#$#@
Richard Guo
Trojan War Simulation
Period 5 


## WHAT IS IT?


    It's a simulation of the Trojan War in which thousands of Achaeans were mobilized to take triremes to storm the beaches of Troy to retrieve Menelaus' wife, Helen of Troy. (She used to be Helen of Sparta.) But there is a twist to it, in this version of the Trojan War, Paris never gets in the war and thus Achilles is truely invincible. Hector on the other hand might get unlucky and be killed by Achilles. The best feature of this version of the Trojan War is that you are an all powerful Greek god and have the ability to destroy soldiers and landscape by clicking on them.



## HOW IT WORKS


   I put together the program by first making everything on the Greece side of the code and making sure it works before applying it to the Trojan side of the code.
 
   It works by asking each breed if one specific condition apply. If the condition applies then the breed will execute the command. 

   The plan was to provide people with a interest people with Ancient Greece and the Greek mythology by allowing them to control the outcomes of a famous Ancient Greek War. 

   I used a 2D layout for the armies and that the soldiers can not move towards the enemy army without clearing the enemy soldiers beforehand. 



## HOW TO USE IT


First click the "setup" button to set up the armies and landscape.

 Then click "run" button because it is necessary for the success of the program and give you the power of a god in order to destroy armies, landscape, or soldiers.

  If you want to bring in Hector and Achilles then you can click the "Special Soldiers" button.

   Clicking "Attack Troy" will unleash Greek soldiers and move Greek solider along with Achilles (if you choose to use "Special Soldiers") towards the Trojans.

    Clicking "Defend Troy" will unleash Trojan soldiers and move Trojan soldiers along with Hector (if you choose to use "Special Soldiers") towards the Greeks. 

     If you want a patch dead then click on it.

      If you want a turtle dead then click on it.

If you want the Greeks to win no matter what and they havent lost yet, then you can click "Deploy the Trojan Horse" and win the war for the Greeks.


"greekarmy" allows you to determine how many greek soldiers can be unleashed from each  blue patch every time you press "Attack Troy"

 "troyarmy" allows you to determine how many greek soldiers can be unleashed from each red patch every time you press "Defend Troy"

  "pos" determines where the Greek Army (blue patches) will be located at.

   "troypos" determines where the Trojan Army (red patches) will be located at. 

    "walloftroy" determines how long it will take before the War of Troy (brown patches) collapse and allow the Greeks to win.



"Greek Soldiers" allows you to see how many Greek soldiers are alive and fighting at the moment.

 "Trojan Soldiers" allows you to see how many Trojan soliders are alive and fighting at the moment.

   "Remaining Greeks" shows you how many more Greek soldiers can die before you can no longer create any more Greek soldiers.

     "Remaining Trojans" shows you how many more Trojan soldiers can die before you can no longer create any more Trojan soldiers.



## THINGS TO NOTICE


  There is a maximum number of soldiers from each side that can die which means the game will eventually end even if you want to drag it on. 

  There are 3 lines of patches in the center of the map that you can not place either army on because the program wouldn't work correctly if they are too close to each other due to the commands of the soldiers. 

  The Greek army can not be placed to the right of the Trojan army and the Trojan army can not be placed to the left of the Greek army. 



## THINGS TO TRY


The sliders offer variety: 

 "greekarmy" allows you to determine how many greek soldiers can be unleashed from each blue patch every time you press "Attack Troy"

    "troyarmy" allows you to determine how many greek soldiers can be unleashed from each red patch every time you press "Defend Troy"

        "pos" determines where the Greek Army (blue patches) will be located at.

     "troypos" determines where the Trojan Army (red patches) will be located at. 

   "walloftroy" determines how long it will take before the War of Troy (brown patches) collapse and allow the Greeks to win.

   It is not suggested to leave the health on if you want to see the actual action going on. It was only designed so that you can see the health of the soldiers and structures decrease. 



## EXTENDING THE MODEL


You can make an entire storyline from the Apple of Discord. to
The judgement of Paris. to 
Menelaus winning Helen's hand out of many Achaeans. to
Odysseus making a pact with all the suitors to defend Menelaus' marriage rights. to
Paris taking Helen home from Sparta. to
Agamemnon commanding all the army of Achaeans to wage war upon Troy. to
Hector defending Troy at all causes. to 
Hector falls by Achilles's hands. to
Paris shooting Achilles in the heel. to
Troy's high walls holding back the Achaeans. to
The Trojan Horse getting inside of Troy to win the war. to
Aeneas escaping and founding the city of seven hills, Rome. to
Poseidon's rage on the Achaeans. to 
The Odysseus's return to Ithaka. 



## CREDITS AND REFERENCES


Coded with the assistance of my friends:
- Kyle Lai
- Milo Robin Bernfield-Millman

and the help of my colleague:
- Yi Cheng Wong
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

baka 3
false
10
Polygon -11221820 true false 111 217 89 232 81 247 71 275 73 283 101 297 125 298 187 296 203 293 210 291 203 273 198 261 185 229 165 214 152 216 143 225 131 233 119 224
Polygon -1184463 true false 110 190 121 198 129 198 137 201 150 199 158 204 167 211 170 212 172 221 172 236 176 242 176 263 181 279 182 286 178 290 180 283 174 272 172 266 169 261 169 252 169 244 156 215
Polygon -13345367 true true 80 57 76 77 70 99 72 130 86 164 100 183 127 198 157 184 176 159 184 129 187 95 180 61 165 48 148 41 123 41 98 41
Polygon -1 true false 142 116 149 107 161 108 168 116 172 128 170 137 161 143 145 141 141 132
Polygon -1184463 true false 149 126 151 121 156 120 161 120 162 126 162 132 158 135 156 136 151 135
Circle -1 true false 147 117 10
Circle -1 true false 98 119 12
Line -2674135 false 86 145 91 153
Line -2674135 false 97 145 102 153
Line -2674135 false 90 144 96 153
Line -2674135 false 158 144 164 153
Polygon -13345367 true true 117 190 117 203 118 212 108 218 129 236 143 231 151 221 162 215 152 209 149 188 124 195
Polygon -16777216 false false 75 137 93 180 128 199 164 180 181 152 151 68 97 64 94 91 79 97 81 133
Polygon -1 true false 86 115 93 106 105 107 112 115 116 127 114 136 105 142 89 140 85 131
Polygon -1184463 true false 95 124 97 119 102 118 107 118 108 124 108 130 104 133 102 134 97 133
Circle -1 true false 93 114 10
Line -16777216 false 124 156 124 150
Polygon -16777216 false false 174 115 164 111 156 105 145 102
Polygon -2064490 true false 123 184 121 177 141 177 140 180 140 183 137 185 128 186
Polygon -16777216 false false 118 208 117 214 107 219 129 235 142 232 148 223 156 218 162 214 152 210 148 189 131 198 129 200 117 193
Polygon -16777216 true false 143 111 150 106 159 107 165 111 167 124 164 116 158 111
Polygon -16777216 false false 81 113 91 109 99 103 110 100
Polygon -16777216 true false 109 110 102 105 93 106 87 110 85 123 88 115 94 110
Polygon -16777216 false false 122 178 139 177 139 183 135 185 128 185 124 183
Polygon -16777216 false false 94 123 97 134 103 134 109 128 108 118 98 115
Polygon -16777216 false false 154 117 149 122 150 131 155 135 161 132 162 126 161 119
Polygon -1184463 true false 106 75 120 86 126 90 142 99 150 104 134 96 140 100 147 102 149 104 150 104 169 139 170 153 175 138 174 175 172 202 173 218 171 232 176 201 183 184 190 160 189 127 193 95 193 86 192 63 186 60 178 46 163 34 133 20 115 20 90 29 82 36 77 54 72 72 68 90 68 92 71 110 69 136 73 165 76 185 98 206 101 207 103 211 102 207 112 218 119 210 118 193 110 188 96 175 93 164 89 155 84 136 85 105
Polygon -16777216 false false 97 124 100 125 105 121 103 117 102 116 97 116
Polygon -16777216 false false 151 127 156 126 158 121 156 117 149 121

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

circle
false
0
Circle -7500403 true true 0 0 300

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
Rectangle -7500403 true true 225 0 225 300
Polygon -8630108 true false 225 0 210 90 240 90 225 0
Polygon -7500403 true true 105 90 120 195 180 195 195 90 105 90 180 195 120 195 195 90
Polygon -16777216 true false 105 90 120 195 180 195 195 90 105 90 120 195
Polygon -16777216 true false 120 195 150 225 180 195 120 195 180 195 150 225 120 195 180 195
Line -16777216 false 120 195 150 225
Polygon -16777216 true false 120 195 180 195 150 225

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

trojan horse
false
0
Line -16777216 false 75 255 225 255
Polygon -7500403 true true 90 255 60 255 60 225 75 180 75 165 60 135 45 90 60 75 60 45 90 30 120 30 135 45 240 60 255 75 255 90 255 105 240 120 225 105 180 120 210 150 225 195 225 210 210 255
Polygon -16777216 false false 210 255 60 255 60 225 75 180 75 165 60 135 45 90 60 75 60 45 90 30 120 30 135 45 240 60 255 75 255 90 255 105 240 120 225 105 180 120 210 150 225 195 225 210
Line -16777216 false 255 90 240 90
Circle -16777216 true false 134 63 24
Line -16777216 false 103 34 108 45
Line -16777216 false 80 41 88 49
Line -16777216 false 61 53 70 58
Line -16777216 false 64 75 79 75
Line -16777216 false 53 100 67 98
Line -16777216 false 63 126 69 123
Line -16777216 false 71 148 77 145
Circle -7500403 true true 146 206 67
Circle -16777216 false false 146 206 67
Circle -7500403 true true 56 206 67
Circle -16777216 false false 56 206 67
Circle -16777216 false false 75 225 30
Circle -16777216 false false 165 225 30

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
