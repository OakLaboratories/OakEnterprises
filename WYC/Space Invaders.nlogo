globals [ score wave boss3x boss3y ]
turtles-own [ id hp gun fire? missc nukec start-time weapon-index]
patches-own [ death-ray ]

; id clarification: 0 = fighter 0.1 = autogun 0.5 = helper 0.75 = shield 1 = bullet good 2.1 = enemy small 2.2 = enemy medium 2.3 = mothership 2.4 = bomber 2.5 = balloon 2.6-2.7 = bosses 3 = bullet bad 3.5 = sharpnel ball 3.25 = missb4 = missile 5 = nuke (6: hp + 7: miss + 8: nuke + 9: shield 10: helper 11: gun +)--> POWERUPS

to setup
  clear-all
  cro 1 [set id 0 set hp 100 set ycor -13 set xcor 0 set weapon-index "bullets"]
  shapeset
  reset-ticks
  if GOD-MODE
  [ask turtle 0
    [set hp 999999999999999 set missc 999999999999999 set nukec 999999999999999
      hatch 1 [set id 0.75 set start-time -751]]]
end

to go
  carefully [
  shapeset
  life-control
  weapon-control
  enemy-control
  pup-control
  tick
  ask patches [set pcolor black set death-ray "False"]
  weapon-setback
  autogun ]
  [user-message "GAME OVER!!!"
    stop]
end

to weapon-setback
  if [missc] of turtle 0 = 0 and [weapon-index] of turtle 0 = "missile"
  [ask turtle 0 [set weapon-index "bullets"]]
  if [nukec] of turtle 0 = 0 and [weapon-index] of turtle 0 = "nukes"
  [ask turtle 0 [set weapon-index "bullets"]]
end

to autogun
  if [gun] of turtle 0 = 3
  [ask turtle 0 [hatch 1 [set id 0.1 set size 0.01 set shape "default"]
      set gun gun - 1]]
  ask turtles with [id = 0.1]
  [if count turtles with [abs(id - 2) < 1] > 0
    [set heading (atan (xcor - ([xcor] of min-one-of turtles with [abs(id - 2) < 1] [distance myself])) (ycor - ([ycor] of min-one-of turtles with [abs(id - 2) < 1] [distance myself]))) + 180
    lt 15
    rt random 30
    if ticks mod 15 = 0
    [hatch 1 [set id 1 set hp 10]]]]
end

to shapeset
  ask turtles with [ id = 0 ] [set shape "fighter" set size 4]
  ask turtles with [ id = 0.5 ] [set shape "AA-turret" set size 4 set color black]
  ask turtles with [ id = 0.75 ] [set shape "protector" set size 5]
  ask turtles with [ id = 1 ] [set shape "bullet" set size 2 set color blue]
  ask turtles with [ id = 2.1 ] [set shape "enemys" set size 3]
  ask turtles with [ id = 2.2 ] [set shape "enemym" set size 4]
  ask turtles with [ id = 2.3 ] [set shape "mothership" set size 7]
  ask turtles with [ id = 2.4 ] [set shape "bomb-deliver" set size 3]
  ask turtles with [ id = 2.45 ] [set shape "bomber" set size 3]
  ask turtles with [ id = 2.5 ] [set shape "balloon" set size 4]
  ask turtles with [ id = 2.60 ] [set shape "boss1" set size 20]
  ask turtles with [ id = 2.61 ] [set shape "boss2" set size 20]
  ask turtles with [ id = 2.62 ] [set shape "boss3" set size 20]
  ask turtles with [ id = 3 ] [set shape "bullet" set size 2 set color red]
  ask turtles with [ id = 3.5 ] [set shape "circle" set size 2 set color red]
  ask turtles with [ id = 4 or id = 3.25 ] [set shape "miss" set size 3]
  ask turtles with [ id = 5 ] [set shape "rocket" set size 3]
  ask turtles with [ id = 6 ] [set shape "hp+" set size 5]
  ask turtles with [ id = 7 ] [set shape "miss+" set size 3]
  ask turtles with [ id = 8 ] [set shape "box" set size 2]
  ask turtles with [ id = 9 ] [set shape "shield" set size 5]
  ask turtles with [ id = 10 ] [set shape "target" set size 2]
  ask turtles with [ id = 11 ] [set shape "arrow" set size 3]
end

; interface control
to mup
  if [ycor] of turtle 0 < 15 [
  ask turtles with [id = 0 or id = 0.75 or id = 0.1] [set ycor ycor + 1]]
end

to mdown
  if [ycor] of turtle 0 > -15 [
  ask turtles with [id = 0 or id = 0.75 or id = 0.1] [set ycor ycor - 1]]
end

to mleft
  if [xcor] of turtle 0 > -15
  [ask turtles with [id = 0 or id = 0.75 or id = 0.1] [set xcor xcor - 1]]
end

to mright
  if [xcor] of turtle 0 < 15 [
  ask turtles with [id = 0 or id = 0.75 or id = 0.1] [set xcor xcor + 1]]
end

to switch-weapons
  ask turtle 0 [
    ifelse weapon-index = "bullets"
    [ifelse missc > 0
      [set weapon-index "missile"]
      [if nukec > 0
        [set weapon-index "nukes"]]]
    [ifelse weapon-index = "missile"
      [ifelse nukec > 0
        [set weapon-index "nukes"]
        [set weapon-index "bullets"]]
      [set weapon-index "bullets"]]]
end

to fire
  ask turtle 0 [
    ifelse not GOD-MODE [
    if weapon-index = "bullets"[
    ifelse gun = 0
    [hatch 1 [set id 1 set hp 10]]
    [ifelse gun = 1
      [hatch 1 [set id 1 set xcor xcor + 1 set hp 10]
        hatch 1 [set id 1 set xcor xcor - 1 set hp 10]]
      [hatch 1 [set id 1 set hp 10]
        hatch 1 [set id 1 set xcor xcor - 1 set hp 10]
        hatch 1 [set id 1 set xcor xcor + 1 set hp 10]]]]
    if weapon-index = "missile"
    [hatch 1 [set id 4 set hp 10]
      set missc missc - 1]
    if weapon-index = "nukes"
    [hatch 1 [set id 5 set hp 10]
      set nukec nukec - 1]]
    [ask patches in-cone 50 2 [set pcolor green]
      ask other turtles with [id != 0.75] [if any? neighbors with [pcolor = green] [set hp hp - 99999999999999]]]]
end

to fire-miss
  ask turtle 0 [
    if missc > 0
    [hatch 1 [set id 4 set hp 10]
      set missc missc - 1]]
end

to fire-nuke
  ask turtle 0 [
    if nukec > 0
    [hatch 1 [set id 5 set hp 10]
      set nukec nukec - 1]]
end

; life control
to life-control
  die-check
  hit
  show-hp
  fireend
end

to die-check
  ; also powerup...
  ask turtles with [ hp <= 0 and abs(id - 2) < 1] [
    if id >= 2.6 and id < 2.7
    [set wave wave + 1
      hatch 1 [set id 6 set hp 50 set heading 0 setxy xcor + random 5 ycor + random 5]
      hatch 1 [set id 7 set hp 50 set heading 0 setxy xcor + random 5 ycor + random 5]
      hatch 1 [set id 8 set hp 50 set heading 0 setxy xcor + random 5 ycor + random 5]
      hatch 1 [set id 9 set hp 50 set heading 0 setxy xcor + random 5 ycor + random 5]
      hatch 1 [set id 10 set hp 50 set heading 0 setxy xcor + random 5 ycor + random 5]
      hatch 1 [set id 11 set hp 50 set heading 0 setxy xcor + random 5 ycor + random 5]]
    ifelse id < 2.4
    [set score score + 100 * (id - 2)]
    [set score score + 25]
    ifelse random difficulty = 0 or id = 2.5 or id = 2.4 or id = 2.45
    [ifelse [gun] of turtle 0 < 2
      [hatch 1 [set id 6 + random 6 set hp 50 set heading 0]]
      [hatch 1 [set id 6 + random 5 set hp 50 set heading 0]]
     set shape "explosion"
     set id 99
     set size 5
     set start-time ticks]
    [set shape "explosion"
      set id 99
      set size 5
      set start-time ticks]]
  ask turtles with [ hp <= 0 and id = 0.5] [set shape "explosion"
      set id 99
      set size 5
      set start-time ticks]
  ask turtles with [ hp <= 0 and abs(id - 2) >= 1 and id != 99] [die]
end

to fireend
  ask turtles with [id = 99]
  [if ticks = start-time + 10
    [die]]
end

to hit
  ask turtles with [ id = 0 ] [if count turtles with [id > 2 and id < 3.1] in-radius 1 > 0 and count turtles with [id = 0.75] = 0 [set hp hp - 10]]
  ask turtles with [ id = 0 ] [if count turtles with [id = 3.5] in-radius 1 > 0 and count turtles with [id = 0.75] = 0 [set hp hp - 50]]
   ask turtles with [ id = 0 ] [if count turtles with [id = 3.25] in-radius 1 > 0 and count turtles with [id = 0.75] = 0 [set hp hp - 25]]
  ask turtles with [ id = 0.5 ] [if count turtles with [id > 2 and id < 3.1 or id = 3.5] in-radius 1 > 0 [set hp hp - 10]]
  ask turtles with [ id = 1 or id = 4 ] [if count turtles with [abs(id - 2)< 1] in-radius 1 > 0 [set hp hp - 10]
    if count turtles with [id >= 2.6 and id < 2.7] in-radius 7 > 0 [set hp hp - 10]]
  ask turtles with [ abs(id - 2) < 1 ] [if count turtles with [id < 2] in-radius 1 > 0 [set hp hp - 10]
    if count turtles with [id = 4] in-radius 1 > 0 [set hp hp - 20 * ceiling(ticks / 5000)]]
  ask turtles with [id >= 2.6 and id < 2.7 and id != 2.611 and id != 2.612] [if count turtles with [id < 2] in-radius 7 > 0 [set hp hp - 10]
    if count turtles with [id = 4] in-radius 7 > 0 [set hp hp - 20 * ceiling(ticks / 5000)]]
  ask turtles with [ id = 3 ] [if count turtles with [id < 1] in-radius 1 > 0 [set hp hp - 50]]
  ask turtles with [ id = 3.25 ] [if count turtles with [id < 1] in-radius 1 > 0 [set hp hp - 50]
    if any? turtles with [id = 1] in-radius 1 [set hp hp - 10]]
  ask turtles with [ id = 3.5 ] [if count turtles with [id < 1] in-radius 1 > 0 [set hp hp - 50]]
end

to show-hp
  ifelse show-hp?
  [ask turtles 
  [ifelse id = 0 or id = 0.5 or abs(id - 2)< 1 and id != 2.611 and id != 2.612
    [set label hp]
    [set label ""]]]
  [ask turtles [set label ""]]
end

; weapons control
to weapon-control
  bullet-control
  sharpnel-control
  missile-control
  nuke-control
end

to bullet-control
  ask turtles with [id = 1] [ifelse ycor < 15.5 and abs(xcor) < 15.5 [fd 1] [die]]
  ask turtles with [id = 3] [ifelse abs(ycor) < 15.5 and abs(xcor) < 15.5 [bk 0.25] [die]]
end

to sharpnel-control
  ask turtles with [id = 3.5] [
    ifelse ycor > -2 and abs(xcor) < 13
    [bk 0.25]
    [hatch 20 [set id 3 set hp 10 set heading random 360 fd 5]
      die]]
end

to missile-control
  ask turtles with [id = 4] [
    ifelse abs(ycor) < 15.5 and abs(xcor) < 15.5 [
    ifelse count turtles with [abs(id - 2) < 1] > 0
    [ set heading (atan (xcor - ([xcor] of min-one-of turtles with [abs(id - 2) < 1] [distance myself])) (ycor - ([ycor] of min-one-of turtles with [abs(id - 2) < 1] [distance myself]))) + 180
      fd 1]
    [ fd 1 ]]
    [die]]
  ask turtles with [id = 3.25] [
    ifelse abs(ycor) < 15.5 and abs(xcor) < 15.5 [
    ifelse any? turtles with [id = 0]  [ set heading (atan (xcor - ([xcor] of turtle 0)) (ycor - ([ycor] of turtle 0))) + 180
      fd 0.25]
    [ fd 0.25 ]]
    [die]]
end

to nuke-control
  ask turtles with [id = 5] [
    ifelse ycor < 5
    [fd 0.2]
    [ask turtles with [id >= 1] in-radius 15 [set hp hp - ceiling (150 * ticks / 5000)]
      ask patches in-radius 15 [set pcolor red]
      ask patches in-radius 10 [set pcolor yellow]
      ask patches in-radius 5 [set pcolor white]
      die]]
end

; enemy control
to enemy-control
  enemy-mvt
  enemy-fire
  incoming
  missile-balloon
  bombing-run
  bombing-run2
  bomber-control
  bomber-control2
  boss1-f
  boss1-fsp
  boss1-fsp2
  boss1-fsp3
  boss2-f
  boss3-f
  boss3-spmvt
  ask turtles with [id = 2.611]
  [ifelse count turtles with [id = 2.61] > 0
    [set xcor [xcor] of one-of turtles with [id = 2.61] - 3
    set ycor [ycor] of one-of turtles with [id = 2.61]
    if ticks mod 10 = 0
    [set heading (atan (xcor - ([xcor] of turtle 0)) (ycor - ([ycor] of turtle 0)))
      hatch 1 [set hp 10 set id 3]]]
    [die]
  ask turtles with [id = 2.612]
  [ifelse count turtles with [id = 2.61] > 0
  [set xcor [xcor] of one-of turtles with [id = 2.61] + 3
    set ycor [ycor] of one-of turtles with [id = 2.61]
    if ticks mod 10 = 0
    [set heading (atan (xcor - ([xcor] of turtle 0)) (ycor - ([ycor] of turtle 0)))
      hatch 1 [set hp 10 set id 3]]]
  [die]]]
end

to incoming
  if count turtles with [ abs(id - 2) < 0.4 ] = 0 and wave mod 30 != 0 or wave = 0
  [set wave wave + 1
    ifelse random 3 = 0
    [crt ceiling (10 * ticks / 5000) [set ycor 15 set xcor random 31 - 14 set id 2.1 set heading 0 set hp 50 * ceiling(ticks / 5000)]]
    [ifelse random 2 = 0
      [crt ceiling(5 * ticks / 5000) [set ycor 15 set xcor random 31 - 14 set id 2.2 set heading 0 set hp 100 * ceiling(ticks / 5000)]]
      [crt 3 * ticks / 7500 [set ycor 15 set xcor random 31 - 14 set id 2.3 set heading 0 set hp 200 * ceiling(ticks / 5000)]]]]
  ifelse wave mod 90 = 30 and count turtles with [id = 2.60] = 0
  [crt 1 [set id 2.60 set heading 0 setxy 0 13 set hp (wave - (wave mod 100)) * 10000 + 10000]]
  [ifelse wave mod 90 = 60 and count turtles with [id = 2.61] = 0
    [crt 1 [set id 2.61 set heading 0 setxy 0 13 set hp (wave - (wave mod 100)) * 15000 + 15000]
      cro 1 [set id 2.611 set xcor [xcor] of one-of turtles with [id = 2.61] - 3 set hp 100]
      cro 1 [set id 2.612 set xcor [xcor] of one-of turtles with [id = 2.61] + 3 set hp 100]]
    [if wave mod 90 = 0 and count turtles with [id = 2.62] = 0 and wave != 0
      [crt 1 [set id 2.62 set heading 0 setxy 0 13 set hp (wave - (wave mod 100)) * 20000 + 20000]]]]
end

to boss1-f
  ask turtles with [id = 2.60]
  [if gun = 0
    [if ticks mod 75 = 0
    [ifelse random 3 = 0
      [hatch 1 [set id 3.25 set xcor xcor - 4 set hp 30]
        hatch 1 [set id 3.25 set xcor xcor - 2 set hp 30]
        hatch 1 [set id 3.25 set hp 30]
        hatch 1 [set id 3.25 set xcor xcor + 2 set hp 30]
        hatch 1 [set id 3.25 set xcor xcor + 4 set hp 30]]
      [ifelse random 2 = 0
        [repeat 5 [hatch 1 [set id 3.5 set hp 10 set heading atan (xcor - [xcor] of turtle 0) (ycor - [ycor] of turtle 0) lt 20 rt random 40]]]
        [set gun 3]]]]]
end

to boss1-fsp
  ask turtles with [id = 2.60]
  [if gun = 3
    [ifelse xcor > -13
    [set xcor xcor - 0.25
      if ticks mod 5 = 0
      [hatch 1 [set hp 10 set id 3]]]
    [set gun 4]]]
end

to boss1-fsp2
  ask turtles with [id = 2.60]
  [if gun = 4
    [ifelse xcor < 13
      [set xcor xcor + 0.25
      if ticks mod 5 = 0
      [hatch 1 [set hp 10 set id 3]]]
      [set gun 5]]]
end

to boss1-fsp3
  ask turtles with [id = 2.6]
  [if gun = 5
    [ifelse xcor > 0
      [set xcor xcor - 0.25
      if ticks mod 5 = 0
      [hatch 1 [set hp 10 set id 3]]]
      [set gun 0]]]
end

to boss2-f
  ask turtles with [id = 2.61]
    [ifelse ticks mod 75 = 0
      [hatch 1 [set id 3.25 set xcor xcor - 6 set hp 30]
        hatch 1 [set id 3.25 set xcor xcor - 4 set hp 30]
        hatch 1 [set id 3.25 set xcor xcor - 2 set hp 30]
        hatch 1 [set id 3.25 set hp 30]
        hatch 1 [set id 3.25 set xcor xcor + 2 set hp 30]
        hatch 1 [set id 3.25 set xcor xcor + 4 set hp 30]
        hatch 1 [set id 3.25 set xcor xcor + 6 set hp 30]]
      [if ticks mod 500 = 0
        [repeat 2 [hatch 1 [set ycor (random 10) + 3 set xcor 16 set id 2.4 set hp 40 set heading 270 set start-time ticks]]
        repeat 1 [hatch 1 [set ycor (random 10) + 3 set xcor -16 set id 2.45 set hp 40 set heading 90 set start-time ticks]]]]]
end

to boss3-f
  ask turtles with [id = 2.62]
  [ifelse gun = 0 [
      ifelse random 700 = 0
      [set gun 3 set start-time ticks]
    [if ticks mod 20 = 0
      [hatch 30 [set id 3 set hp 10 set heading 90 - random 180]]]]
  [if gun = 3 [ifelse ticks > start-time + 150
      [set gun 0]
      [set boss3x xcor set boss3y ycor
        ask patches with [pxcor = boss3x and pycor < boss3y] [set pcolor green set death-ray "True"]
        ask other turtles [
          if death-ray = "True"
          [set color green
            die]]]]]]
end

to boss3-spmvt
  ask turtles with [id = 2.62 and gun = 3]
  [if ticks mod 10 = 0
  [ifelse xcor < [xcor] of turtle 0
    [set xcor xcor + 1]
    [set xcor xcor - 1]]]
end

to enemy-mvt
  if ticks mod 10 = 0 [
  ask turtles with [ abs(id - 2) < 0.6 and id != 2.4 and id != 2.45 and id != 2.611 and id != 2.612 and gun < 3]
  [ifelse xcor > -14 and xcor < 14
    [ifelse ycor > -2
    [ifelse ycor < 15
      [ifelse random 2 = 0
        [set ycor ycor + 1
          ifelse random 2 = 0
          [set xcor xcor + 1]
          [set xcor xcor - 1]]
        [set ycor ycor - 1
          ifelse random 2 = 0
          [set xcor xcor + 1]
          [set xcor xcor - 1]]]
      [set ycor ycor - 1
        ifelse random 2 = 0
        [set xcor xcor - 1]
        [set xcor xcor + 1]]]
    [ifelse random 2 = 0
      [set ycor ycor + 1
        ifelse random 2 = 0
          [set xcor xcor - 1]
          [set xcor xcor + 1]]
      [ifelse random 2 = 0
        [set xcor xcor - 1]
        [set xcor xcor + 1]]]]
  [ifelse xcor = -14
    [set xcor xcor + 1]
    [set xcor xcor - 1]]]
  ask turtles with [ (id - 2) > 0.6 and (id - 2) < 0.7 and gun < 3]
  [ifelse xcor > -9 and xcor < 9
    [ifelse ycor > -2
    [ifelse ycor < 10
      [ifelse random 2 = 0
        [set ycor ycor + 1
          ifelse random 2 = 0
          [set xcor xcor + 1]
          [set xcor xcor - 1]]
        [set ycor ycor - 1
          ifelse random 2 = 0
          [set xcor xcor + 1]
          [set xcor xcor - 1]]]
      [set ycor ycor - 1
        ifelse random 2 = 0
        [set xcor xcor - 1]
        [set xcor xcor + 1]]]
    [ifelse random 2 = 0
      [set ycor ycor + 1
        ifelse random 2 = 0
          [set xcor xcor - 1]
          [set xcor xcor + 1]]
      [ifelse random 2 = 0
        [set xcor xcor - 1]
        [set xcor xcor + 1]]]]
  [ifelse xcor = -9
    [set xcor xcor + 1]
    [set xcor xcor - 1]]]]
end

to enemy-fire
  ask turtles with [ abs(id - 2) < 1]
  [ifelse random (1.5 * (15 - difficulty)) = 0
    [set fire? True]
    [set fire? False]]
  smallfire
  mediumfire
  bigfire
end

to smallfire
  ask turtles with [ id = 2.1 and fire? ]
  [if random 2 = 0
    [hatch 1 [set id 3 set hp 10]]]
end

to mediumfire
  ask turtles with [ id = 2.2 and fire? ]
  [if random 3 = 0
    [hatch 2 [set id 3 set hp 10 rt 45 lt random 90]]]
end

to bigfire
  ask turtles with [ id = 2.3 and fire? ]
  [if random 7 = 0
    [hatch 1 [set id 3.5 set hp 10 set heading atan (xcor - [xcor] of turtle 0) (ycor - [ycor] of turtle 0) lt 20 rt random 40]]]
end

to missile-balloon
  if random (1500 - difficulty) = 0 and count turtles with [id >= 2.6 and id < 2.7] = 0
  [crt 1 [setxy (random 31) - 14 14 set id 2.5 set hp 100]]
  missf
end

to missf
  ask turtles with [id = 2.5]
  [if ticks mod 30 = 0
    [hatch 1 [set id 3.25 set hp 20]]]
end

to bombing-run
  if random (750 - difficulty) = 0 and count turtles with [id >= 2.6 and id < 2.7] = 0
  [crt 1 [set ycor (random 10) + 3 set xcor 16 set id 2.4 set hp 40 set heading 270 set start-time ticks]]
end

to bombing-run2 
  if random (750 - difficulty) = 0 and count turtles with [id >= 2.6 and id < 2.7] = 0
  [crt 1 [set ycor (random 10) + 3 set xcor -16 set id 2.45 set hp 40 set heading 90 set start-time ticks]]
end

to bomber-control
  ask turtles with [id = 2.4] [
  ifelse xcor > -16
  [fd 0.5
    if ticks > start-time + random 30 and ticks mod 5 = 0
      [hatch 1 [set heading 0 set id 3 set hp 10]]]
  [die]]
end

to bomber-control2
  ask turtles with [id = 2.45] [
  ifelse xcor < 16
  [fd 0.5
    if ticks > start-time + random 30 and ticks mod 5 = 0
      [hatch 1 [set heading 0 set id 3 set hp 10]]]
  [die]]
end

; powerup control
to pup-control
  autogen
  pupmvt
  hp+
  nukes+
  miss+
  gun+
  shield-on
  helper
  helper-control
end

to autogen
  if ticks mod 500 = 0 and random 5 = 0
  [cro 1 [set id random 6 + 6 set ycor 15 set hp 50 set xcor random-xcor]]
end

to pupmvt
  ask turtles with [id > 5 and id != 99] [ifelse ycor > -16 and abs(xcor) < 16 [bk 0.2] [die]]
end

to hp+
  ask turtle 0 [if count turtles with [id = 6] in-radius 1.5 > 0 [set hp hp + 50 * count turtles with [id = 6] in-radius 1.5]]
  ask turtles with [id = 6] [if count turtles with [id = 0] in-radius 1.5 > 0 [die]]
end

to miss+
  ask turtle 0 [if count turtles with [id = 7] in-radius 1.5 > 0 [set missc missc + 10 * count turtles with [id = 7] in-radius 1.5]]
  ask turtles with [id = 7] [if count turtles with [id = 0] in-radius 1.5 > 0 [die]]
end

to nukes+
  ask turtle 0 [if count turtles with [id = 8] in-radius 1.5 > 0 [set nukec nukec + 1 * count turtles with [id = 8] in-radius 1.5]]
  ask turtles with [id = 8] [if count turtles with [id = 0] in-radius 1.5 > 0 [die]]
end

to gun+
  ask turtle 0 [if count turtles with [id = 11] in-radius 1.5 > 0 [set gun gun + 1 * count turtles with [id = 11] in-radius 1.5]]
  ask turtles with [id = 11] [if count turtles with [id = 0] in-radius 1.5 > 0 [die]]
end

to shield-on
  ask turtle 0 [if count turtles with [id = 9] in-radius 1.5 > 0 and count turtles with [id = 0.75] in-radius 1.5 = 0 [hatch 1 [set id 0.75 set start-time ticks set hp 20]]]
  ask turtles with [id = 0.75] [if ticks = start-time + 750 [die]]
  ask turtles with [id = 9] [if count turtles with [id = 0] in-radius 1.5 > 0 [die]]
end

to helper
  ask turtle 0 [if count turtles with [id = 10] in-radius 1.5 > 0 [hatch 1 [set id 0.5 set hp 30]]]
  ask turtles with [id = 10] [if count turtles with [id = 0] in-radius 1.5 > 0 [die]]
end

to helper-control
  ask turtles with [id = 0.5]
  [if count turtles with [abs(id - 2) < 1] > 0
    [set heading (atan (xcor - ([xcor] of min-one-of turtles with [abs(id - 2) < 1] [distance myself])) (ycor - ([ycor] of min-one-of turtles with [abs(id - 2) < 1] [distance myself]))) + 180
    lt 15
    rt random 30
    if ticks mod 5 = 0
    [hatch 1 [set id 1]]]]
end

to helper-control2
  ;hackingly op, thus disabled
  ask turtles with [id = 0.5]
  [set heading 0
    lt 45
    rt random 90
    if any? turtles with [id > 1] in-cone 50 2
    [ask other turtles with [id > 1] in-cone 50 2 [set hp hp - 999999999999999]
      ask patches in-cone 50 2 [set pcolor green]]]
  if ticks mod 5 = 0 [ask patches [set pcolor black]]
end
@#$#@#$#@
GRAPHICS-WINDOW
316
22
755
482
16
16
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
-16
16
1
1
1
ticks
30.0

BUTTON
74
48
140
81
NIL
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

BUTTON
108
246
171
279
up
mup
NIL
1
T
OBSERVER
NIL
I
NIL
NIL
0

BUTTON
109
279
172
312
down
mdown
NIL
1
T
OBSERVER
NIL
K
NIL
NIL
0

BUTTON
172
280
238
313
right
mright
NIL
1
T
OBSERVER
NIL
L
NIL
NIL
0

BUTTON
47
279
110
312
left
mleft
NIL
1
T
OBSERVER
NIL
J
NIL
NIL
0

BUTTON
109
312
172
345
NIL
fire
NIL
1
T
OBSERVER
NIL
F
NIL
NIL
0

BUTTON
157
49
220
82
NIL
go
T
1
T
OBSERVER
NIL
G
NIL
NIL
1

SLIDER
64
97
236
130
difficulty
difficulty
1
11
5
1
1
NIL
HORIZONTAL

SWITCH
88
141
201
174
show-hp?
show-hp?
0
1
-1000

MONITOR
29
187
91
236
missile
[missc] of turtle 0
17
1
12

MONITOR
94
187
151
236
nukes
[nukec] of turtle 0
17
1
12

MONITOR
79
352
136
401
NIL
score
1
1
12

BUTTON
75
412
203
445
NIL
switch-weapons
NIL
1
T
OBSERVER
NIL
D
NIL
NIL
0

MONITOR
163
189
241
238
weapon
[weapon-index] of turtle 0
17
1
12

MONITOR
138
355
195
400
NIL
wave
17
1
11

SWITCH
80
458
199
491
GOD-MODE
GOD-MODE
1
1
-1000

@#$#@#$#@
Yicheng Wang
Period 5

## WHAT IS IT?

This netlogo program is a remake/improvement upon the gamed named "space invader." In this game, enemy aircrafts of all types come into the screen and try to attack you. Your job is to survive the attack while killing enemy aircrafts in the process. This game is endless, different aircrafts will appear in groups and the game gets harder and harder as time passes. When an enemy aircraft is destroyed or when you're lucky, there'll be a powerup dropped from the top of the screen. Collect these powerups to make your life easier. There're three bosses, they'll appear in wave 30, 60 and 90 respectively. After you kill the 3rd boss, at wave 120, the first boss will regenerate and become stronger. Good luck!

## HOW IT WORKS

The setup command creates the aircraft which the user is going to control. This makes sure that the fighter is turtle 0, making targeting a lot easier.

The universal command is the go command, which is split into a few parts:
    > Shape control
    > life control
    > weapons control
    > enemy control
    > powerups control
Each turtle has a custom variable called "id," this is a number which indicates which type of turtle it is. This is similar to breeds, but works better for grouping turtles together because with numbers you can use greater than, less than, and other aritmatic function to select certain turtles. (a comprehensive guide to id number is provided in the code section)

The shape contorl part of the go command sets the shape of each type of turtle by assigning shapes based on id #'s.

The life control part checks if anyone is dead. A airplane's hitpoint is denoted by its custom variable hp, and when hp is <= 0, it "transforms" into the explosion animation. This part also governs the interaction between bullets/missiles with other aircrafts, with a group of "in-radius" statements, each turtle is going to try to detect if there's any enemies in radius and then do respective damage

The weapon control part controls the flight pass of the missile and other projectiles. The missile resets its heading every tick, the nuke expload at a certain altitude, the bullet just fly straight up and down.

The enemy control part control the random movement of enemy aircrafts as well as the deliverative movement and special weapons for the bosses. Each time, if there's no enemy aircrafts on the screen, the wave variable will be set to wave + 1 and a new wave of enemies will be generated.

The powerups control works very much like the bullet-aircraft interaction of the life control part. It also uses in-radius function for item detection and interaction. The airplane, upon receiving the powerup, will perform the respective command.

The neat thing about the go command is that it has this gigantic "carefully" command block around its parts. This is because the only reason why there'll be an error is if turtle 0 died, which means you lose. So the carefully command surpresses the error message and sends out "GAME OVER!!" message.

## HOW TO USE IT

The interface is pretty self explainatory, the movement is NOT awsd, but rahter jikl for left, up, down and right respectively. The "weapon" moiter tells you which weapon you are currently using and by pressing f (fire), you'll fire that weapon. Note that only bullets have infinite ammo, if you were firing and run out of missiles/nukes, the weapon is automatically set back to bullets. The difficulty slider decides how difficult the game will be, 5 is for intermediate players, 1 is for beginners, 11 is for professionals. The show-hp? switch will display the hp next to the aircraft if it is turned on

The "GOD-MODE" switch is not recommended to be used, further explained below.

## THINGS TO TRY

IF AND ONLY IF YOU ARE FUSTRATED BY THE FACT THAT YOU CANNOT EVEN SURVIVE TO SEE ALL OF THE BOSSES, TURN ON "GOD-MODE" DURING SETUP.

## STRATEGY

Here're some recommendations from the creator (although I am in no place to dictate what to do as that I've never survived pass the 2nd at difficulty = 5)

Missiles: good thing to use to catch those pesky fast carpet bombers, they are too fast for your bullets and nukes, but homing missile will do the job. Apart from that, you can use missiles to clear out enemy motherships when you're busy avoiding bullets

Nukes: Save them!! In late game they are especially useful, they can clear out an entire area, which contains more and more enemy as the wave increases.

Gun upgrades are important, they are basically what you win on since both missiles and nukes are limited

When you have a shield, go all out, but remember to retreat in time before the shield wears off, it can catch you off-guard sometimes

Turrets are cool, the placement of them is very important, a turret-shield combination is REALLY devastating to the enemy as that the shield will shield off enemy attacks while the turrets sweep the area with their rapid-firing machine guns

Missile balloons and bombers are annoying, especially early in game, make sure you get out of the bombing area because it's hard to get out of the carbet bombing session unharmed. The best way to deal with missile balloons is to face it, directly. This way its missiles become practically useless as that they can only fly towards you (as well as your bullets) anyway.

Remember, you can hold down the fire botton to fire continously, but this means that you cannot move. Early in game this is a great way to set up traps for bombers, they also drop goodies, so it's a good strategy.

## CREDITS AND REFERENCES

Alvin Lin helped me with none-wrapping heading determination.
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

aa-turret
true
14
Circle -6459832 true false 60 60 180
Line -16777216 true 150 60 150 240
Line -16777216 true 60 150 240 150
Line -16777216 true 105 75 195 225
Line -16777216 true 195 75 105 225
Line -16777216 true 225 105 75 195
Line -16777216 true 75 105 225 195
Circle -7500403 true false 90 90 120
Rectangle -16777216 true true 105 150 195 180
Rectangle -7500403 true false 120 45 135 165
Rectangle -7500403 true false 165 45 180 165
Rectangle -16777216 true true 120 75 135 120
Rectangle -16777216 true true 165 75 180 120
Circle -16777216 false true 90 90 120
Rectangle -16777216 false true 120 45 135 165
Rectangle -16777216 false true 165 45 180 165

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

arrow 3
true
0
Polygon -7500403 true true 135 255 105 300 105 225 135 195 135 75 105 90 150 0 195 90 165 75 165 195 195 225 195 300 165 255

balloon
false
0
Circle -7500403 true true 73 0 152
Polygon -7500403 true true 219 104 205 133 185 165 174 190 165 210 165 225 150 225 147 119
Polygon -7500403 true true 79 103 95 133 115 165 126 190 135 210 135 225 150 225 154 120
Rectangle -6459832 true false 129 241 173 273
Line -16777216 false 135 225 135 240
Line -16777216 false 165 225 165 240
Line -16777216 false 150 225 150 240

bomb-deliver
true
0
Polygon -11221820 true false 165 90 180 120 175 169
Polygon -14835848 true false 150 0 165 105 150 105
Polygon -7500403 true true 135 45 165 75 180 195 210 225 210 240 135 210
Rectangle -2674135 true false 150 135 165 195

bomber
true
0
Polygon -11221820 true false 135 45 120 90 135 135
Polygon -7500403 true true 165 45 135 45 120 210 90 240 90 255 165 240
Circle -7500403 true true 135 30 30
Line -13345367 false 135 180 135 120
Rectangle -13345367 true false 142 128 157 173

boss1
true
0
Polygon -7500403 true true 30 120 60 90 150 60 240 90 270 120 240 150 150 165 60 150
Line -7500403 true 195 195 195 150
Line -7500403 true 105 195 105 150
Rectangle -7500403 true true 90 180 210 210
Circle -7500403 true true 240 105 30
Circle -7500403 true true 30 105 30
Line -16777216 false 105 75 195 75
Line -16777216 false 60 90 240 90
Line -16777216 false 60 150 240 150
Circle -2674135 true false 165 180 30
Circle -2674135 true false 105 180 30
Rectangle -7500403 true true 255 90 270 150
Rectangle -7500403 true true 30 90 45 150
Line -16777216 false 30 120 270 120
Line -16777216 false 30 135 270 135
Line -16777216 false 30 105 270 105

boss2
true
0
Circle -6459832 true false 225 150 30
Circle -6459832 true false 45 150 30
Rectangle -2674135 true false 120 45 180 240
Polygon -7500403 true true 255 120 240 150 225 120
Polygon -7500403 true true 45 120 60 150 75 120
Line -7500403 true 240 120 240 105
Line -7500403 true 60 120 60 105
Polygon -7500403 true true 15 135 105 195 195 195 285 135
Rectangle -11221820 true false 135 210 165 225
Line -6459832 false 60 165 60 195
Line -6459832 false 240 165 240 195

boss3
true
0
Polygon -7500403 true true 30 120 150 45 270 120 180 165 120 165
Rectangle -7500403 true true 225 165 240 210
Rectangle -7500403 true true 60 165 75 210
Rectangle -7500403 true true 135 165 165 210
Polygon -1184463 true false 120 105 150 75 180 105 150 135
Circle -2674135 true false 135 90 30
Polygon -2674135 true false 15 165 45 150 255 150 285 165 150 180
Circle -10899396 true false 135 180 30
Rectangle -10899396 true false 225 195 240 210
Rectangle -10899396 true false 60 195 75 210

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

bullet
true
0
Rectangle -7500403 true true 135 75 165 210

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

enemym
true
0
Polygon -7500403 true true 90 180 210 180 150 45 90 180
Polygon -7500403 true true 45 150 75 180 225 180 255 150
Rectangle -7500403 true true 75 120 90 180
Rectangle -7500403 true true 210 120 225 180
Polygon -7500403 true true 90 45 150 60 210 45
Circle -7500403 true true 120 150 60
Polygon -7500403 true true 135 195 150 270 165 195
Rectangle -2674135 true false 45 165 254 173
Circle -2674135 true false 129 114 42

enemys
true
0
Polygon -7500403 true true 45 180 90 120 210 120 255 180
Circle -7500403 true true 120 90 60
Circle -2674135 true false 90 135 30
Circle -2674135 true false 180 135 30
Circle -2674135 true false 135 135 30

explosion
true
0
Polygon -2674135 true false 105 75 105 105 60 90 90 135 45 150 90 180 75 210 120 210 165 225 195 240 195 180 255 135 195 120 180 60 135 105
Polygon -1184463 true false 120 120 90 120 135 150 75 150 135 165 90 195 150 195 180 210 180 165 210 135 180 135 165 90 150 120 120 105
Polygon -1 true false 135 135 150 135 165 135 180 150 165 180 150 150

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

fighter
true
0
Polygon -7500403 true true 105 165 120 150 180 150 195 165 180 225 120 225
Polygon -7500403 true true 150 30 135 90 135 150 60 195 60 210 135 210 135 225 90 240 90 255 210 255 210 240 165 225 165 210 240 210 240 195 165 150 165 90
Rectangle -11221820 true false 60 196 240 207
Line -7500403 true 75 150 75 195
Line -7500403 true 225 150 225 195
Polygon -11221820 true false 143 90 143 135 158 135 158 90 143 90

fire
false
0
Polygon -7500403 true true 151 286 134 282 103 282 59 248 40 210 32 157 37 108 68 146 71 109 83 72 111 27 127 55 148 11 167 41 180 112 195 57 217 91 226 126 227 203 256 156 256 201 238 263 213 278 183 281
Polygon -955883 true false 126 284 91 251 85 212 91 168 103 132 118 153 125 181 135 141 151 96 185 161 195 203 193 253 164 286
Polygon -2674135 true false 155 284 172 268 172 243 162 224 148 201 130 233 131 260 135 282

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

hp+
true
0
Rectangle -1 true false 90 105 210 210
Rectangle -7500403 true true 120 150 180 165
Rectangle -7500403 true true 135 135 165 180
Line -1 false 120 105 120 75
Line -1 false 120 75 180 75
Line -1 false 180 75 180 105

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

miss
true
0
Polygon -7500403 true true 150 60 135 105 135 210 120 240 150 240 180 240 165 210 165 105
Polygon -7500403 true true 135 120 120 150 135 150 165 150 180 150 165 120
Rectangle -13791810 true false 135 165 165 180
Rectangle -13791810 true false 135 195 165 210

miss+
true
0
Polygon -7500403 true true 90 60 75 105 75 210 60 240 90 240 120 240 105 210 105 105
Polygon -7500403 true true 150 60 135 105 135 210 120 240 150 240 180 240 165 210 165 105
Polygon -7500403 true true 210 60 225 105 225 210 240 240 210 240 180 240 195 210 195 105
Polygon -7500403 true true 75 120 60 150 75 150 105 150 120 150 105 120
Rectangle -13791810 true false 75 165 105 180
Rectangle -13791810 true false 75 195 105 210
Rectangle -13791810 true false 195 195 225 210
Rectangle -13791810 true false 195 165 225 180
Polygon -7500403 true true 225 120 240 150 225 150 195 150 180 150 195 120
Polygon -7500403 true true 135 120 120 150 135 150 165 150 180 150 165 120
Rectangle -13791810 true false 135 165 165 180
Rectangle -13791810 true false 135 195 165 210

mothership
true
0
Circle -7500403 true true 60 60 180
Circle -16777216 true false 116 116 67
Polygon -7500403 true true 255 150 210 120 240 150
Polygon -7500403 true true 45 150 90 120 60 150
Polygon -7500403 true true 60 30 135 150 165 150 240 30
Circle -2674135 true false 129 144 42
Rectangle -2674135 true false 135 45 165 90
Line -7500403 true 45 150 150 285
Line -7500403 true 255 150 150 285

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

protector
true
0
Circle -13840069 false false 15 15 270
Circle -13840069 false false 30 30 240

rocket
true
0
Polygon -7500403 true true 120 165 75 285 135 255 165 255 225 285 180 165
Polygon -1 true false 135 285 105 135 105 105 120 45 135 15 150 0 165 15 180 45 195 105 195 135 165 285
Rectangle -7500403 true true 147 176 153 288
Polygon -7500403 true true 120 45 180 45 165 15 150 0 135 15
Line -7500403 true 105 90 135 105
Line -7500403 true 135 105 165 105
Line -7500403 true 165 105 195 90
Line -7500403 true 105 150 135 165
Line -7500403 true 135 165 165 165
Line -7500403 true 165 165 195 150
Circle -1184463 true false 129 114 42
Polygon -16777216 true false 140 117 159 117 150 135
Polygon -16777216 true false 150 135 130 135 143 154
Polygon -16777216 true false 150 135 170 135 157 154

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

shield
true
0
Polygon -7500403 true true 105 90 150 120 195 90 195 180 150 240 105 180
Rectangle -13840069 true false 105 135 195 150
Rectangle -13840069 true false 105 165 195 180

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

tank
true
0
Rectangle -7500403 true true 144 0 159 105
Rectangle -6459832 true false 195 45 255 255
Rectangle -16777216 false false 195 45 255 255
Rectangle -6459832 true false 45 45 105 255
Rectangle -16777216 false false 45 45 105 255
Line -16777216 false 45 75 255 75
Line -16777216 false 45 105 255 105
Line -16777216 false 45 60 255 60
Line -16777216 false 45 240 255 240
Line -16777216 false 45 225 255 225
Line -16777216 false 45 195 255 195
Line -16777216 false 45 150 255 150
Polygon -7500403 true true 90 60 60 90 60 240 120 255 180 255 240 240 240 90 210 60
Rectangle -16777216 false false 135 105 165 120
Polygon -16777216 false false 135 120 105 135 101 181 120 225 149 234 180 225 199 182 195 135 165 120
Polygon -16777216 false false 240 90 210 60 211 246 240 240
Polygon -16777216 false false 60 90 90 60 89 246 60 240
Polygon -16777216 false false 89 247 116 254 183 255 211 246 211 237 89 236
Rectangle -16777216 false false 90 60 210 90
Rectangle -16777216 false false 135 105 165 120
Rectangle -16777216 false false 143 0 158 105
Rectangle -16777216 false false 135 90 165 105
Rectangle -16777216 false false 135 120 165 135

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
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180

@#$#@#$#@
0
@#$#@#$#@
