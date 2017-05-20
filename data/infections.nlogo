globals
[
  border
  deaths
  reduced-inf-chance
  double-inf-chance
  num-rash
  americans
  europeans
  asians
  africans
]

turtles-own
[
  susceptible?
  latent?
  prodromic?
  rash?
  dead?
  cured?
  immune?
  
  american?
  european?
  asian?
  african?
  
  latent-time
  prodromic-time
  rash-time
  cured-time
  my-cured-ticks
]


to setup
  clear-all
  setup-world
  setup-people
  setup-counters
  reset-ticks
end

;set border patches and continents
to setup-world
  ask patches with [ pycor > 4 and pxcor < 0 ] [ set pcolor 61 ] ;north america
  ask patches with [ pycor > 12 and pxcor > 0 ] [ set pcolor 102 ] ;europe
  ask patches with [ pycor < 4 and pxcor < 0 ] [ set pcolor 11 ] ;africa
  ask patches with [ pycor < 12 and pxcor > 0 ] [ set pcolor 41 ] ;asia
  set border patches with [ pxcor = 0 or (pxcor < 0 and pycor = 4 ) or (pxcor > 0 and pycor = 12 ) or pycor = max-pycor or pycor = 0 - max-pycor or pxcor = max-pxcor or pxcor = 0 - max-pxcor  ]
  ask border [ set pcolor grey ]
end

;place people inside continents
to place-people
  let p random 100
  if (p < 8) [ set ycor random-bw 5 20
    set xcor random-bw -32 -1
    set american? true
    set americans americans + 1
  ]
  if (p >= 8 and p < 20) [ set ycor random-bw 13 20
      set xcor random-bw 1 32
      set european? true
      set europeans europeans + 1
    ]
  if (p >= 20 and p < 36) [ set ycor random-bw -20 3
        set xcor random-bw -32 -1
        set african? true
        set africans africans + 1
      ]
  if (p >= 36) [
        set ycor random-bw -20 11
        set xcor random-bw 1 32
        set asian? true
        set asians asians + 1
      ]
end

;setups every turtles and picks one of them to be the patient zero
to setup-people
    
    create-turtles 600 [ 
      
      set american? false
      set european? false
      set asian? false
      set african? false
      
      place-people
      ifelse (random 100 < immunes) [
        set immune? true
        set susceptible? false 
      ]
        [ set susceptible? true
          set immune? false 
        ]
      set latent? false
      set prodromic? false
      set rash? false
      set dead? false
      set cured? false
      
      set latent-time 0
      set prodromic-time 0
      set rash-time 0
      set my-cured-ticks 0
      
      set cured-time random-normal average-immunity-time average-immunity-time / 4
      if cured-time > average-immunity-time * 2 [ set cured-time average-immunity-time * 2 ]
      if cured-time < 0 [ set cured-time 0 ]
     
      set shape "circle"
      set size .6
             

      assign-color
    ]
    
    ifelse (patient-zero = "american") [ ask one-of turtles with [ american? ] [ setup-patient-zero ] ]
      [ ifelse (patient-zero = "european") [ ask one-of turtles with [ european? ] [ setup-patient-zero ] ]
          [ ifelse (patient-zero = "african") [ ask one-of turtles with [ african? ] [ setup-patient-zero ] ]
             [ ask one-of turtles with [ asian? ] [ setup-patient-zero ] ]
            ] ]
end

to setup-patient-zero
  set shape "person"
  set latent? true
  set susceptible? false
  set immune? false
  set color yellow
  set size 1.5
end

;assigns colors to turtles
to assign-color
  if dead? or cured? [set color blue]
  if rash? [set color 14]
  if prodromic? [set color 26]
  if latent? [ set color yellow ]
  if susceptible?  [ set color white ]
  if immune? [ set color green ]
end


;set some global counters
to setup-counters
  set deaths 0
  set num-rash 0
  set reduced-inf-chance infection-chance / 100
  set double-inf-chance infection-chance * 2
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; G O ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to born
  
  create-turtles 1 [ 
      
      set american? false
      set european? false
      set asian? false
      set african? false
      
      place-people
      ifelse (random 100 < immunes) [
        set immune? true
        set susceptible? false 
      ]
        [ set susceptible? true
          set immune? false 
        ]
      set latent? false
      set prodromic? false
      set rash? false
      set dead? false
      set cured? false
      
      set latent-time 0
      set prodromic-time 0
      set rash-time 0
      set my-cured-ticks 0
      
      set cured-time random-normal average-immunity-time average-immunity-time / 4
      if cured-time > average-immunity-time * 2 [ set cured-time average-immunity-time * 2 ]
      if cured-time < 0 [ set cured-time 0 ]

      set shape "circle"
      set size .6
      assign-color
      
    ]

end

to go
  
  if all? turtles [ cured? or immune? or dead? or susceptible? ]
    [ stop ]
  
  ;born
  
  if (ticks mod 3 = 0) [ born ]
  
  ask turtles with [not dead?] [
    let my-travel-chance travel-chance-north
    if ( asian? or african? ) [ set my-travel-chance travel-chance-south ]
    if prodromic? [ set my-travel-chance my-travel-chance / 2 ]
    if rash? [ set my-travel-chance my-travel-chance / 5 ]
    ;if ( african? or asian? ) [ set my-travel-chance my-travel-chance / 2 ]
    
    ifelse (random-float 100 < my-travel-chance) [
         ifelse ( separate-n-s = "yes" ) [
          ifelse (asian? or african?) [ travel-south ] [ travel-north ] ] ;close north-south borders
           [ travel ]
      ] [ move ]
   ] 
  
  ask turtles with [ latent? ] [ 
    set latent-time latent-time + 1
    if (latent-time > 21)[
      set latent? false
      set prodromic? true
    ]
  ]
  
  ask turtles with [ prodromic? ] [
    infect
    set prodromic-time prodromic-time + 1
    if (prodromic-time > 9)[
      set prodromic? false
      set rash? true
      set num-rash num-rash + 1
      if ( quarantine? = true ) [ if (num-rash = quarantine-threshold) [ close-borders ] ]
    ]
  ]
  
  ask turtles with [ rash? ] [ 
    infect
    set rash-time rash-time + 1
    if (rash-time > 36)[
      set rash? false
      ifelse (random 100 < 30) [
        set dead? true
        set deaths deaths + 1
        set shape "x"
        ;die
        ]
       [;survived
         ifelse (model = "SIR" or model = "SIRS") [ set cured? true ]
           [ set susceptible? true ]
       ]
    ]
  ]
  
  if (model = "SIRS") [
    ask turtles with [ cured? ] [ 
      set my-cured-ticks my-cured-ticks + 1
      if (my-cured-ticks > 3 * cured-time) [
        set cured? false
        set susceptible? true
        set my-cured-ticks 0
      ]
    ]
  ]
  
  ask turtles [ assign-color ]
  
  tick

end

;move turtles into their countries
to move
  rt random-float 360
  if (member? (patch-ahead 1) border) [rt 180]
  ifelse american? or european? [ fd 0.8 ]
    [ fd 0.2 ]
end

;travel to random continent
to travel
    let p random 10
  if (p < 3) [ set ycor random-bw 5 20
    set xcor random-bw -32 -1
  ]
  if (p >= 3 and p < 7) [ set ycor random-bw 13 20
      set xcor random-bw 1 32
    ]
  if (p = 7) [ set ycor random-bw -20 3
        set xcor random-bw -32 -1
      ]
  if (p >= 8) [
        set ycor random-bw -20 11
        set xcor random-bw 1 32
      ]
end

;travel only to nothern countries
to travel-north
  let p random 2
  if (p = 0) [ set ycor random-bw 5 20
    set xcor random-bw -32 -1
  ]
  if (p = 1) [ set ycor random-bw 13 20
      set xcor random-bw 1 32
    ]
end

;travel only to southern countries
to travel-south
  let p random 2
  if (p = 0) [ set ycor random-bw -20 3
        set xcor random-bw -32 -1
      ]
  if (p = 1) [
        set ycor random-bw -20 11
        set xcor random-bw 1 32
      ]
end

;infect neighbor turtles
to infect
   let nearby-susceptible (turtles-on neighbors)
     with [ susceptible? ]

     if nearby-susceptible != nobody [ 
       ifelse rash? [
         ask nearby-susceptible [
           ifelse (african? or asian?) [
             if random-float 100 < double-inf-chance [
             set latent? true
             set susceptible? false ]
             ]
           [ if random-float 100 < infection-chance [
             set latent? true
             set susceptible? false 
             ]]
          ]
       ]
       [ ;prodromic
          ask nearby-susceptible [
            if random-float 100 < reduced-inf-chance [
              set latent? true
              set susceptible? false 
              ]
          ]
       ]
     ]
end

;quarantine
to close-borders 
  set travel-chance-north 0
  set travel-chance-south 0
end

;returns a random number between given ]min and max]
;random (max-extreme - min-extreme) + min-extreme
to-report random-bw [minp maxp]
  report random-float (maxp - minp) + minp
end
@#$#@#$#@
GRAPHICS-WINDOW
584
10
1264
471
33
21
10.0
1
10
1
1
1
0
1
1
1
-33
33
-21
21
1
1
1
ticks
30.0

BUTTON
479
185
553
218
Setup
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
478
107
547
140
Clear
ca
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
484
234
547
267
Go
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
23
26
208
59
infection-chance
infection-chance
40
90
50
1
1
%
HORIZONTAL

MONITOR
578
493
688
538
dead asians
count turtles with [dead? and asian?] / asians * 100
2
1
11

SLIDER
24
74
235
107
travel-chance-north
travel-chance-north
0
1
0.5
0.1
1
%
HORIZONTAL

SLIDER
170
186
425
219
quarantine-threshold
quarantine-threshold
1
20
20
1
1
people
HORIZONTAL

SLIDER
213
26
385
59
immunes
immunes
0
40
0
1
1
%
HORIZONTAL

CHOOSER
21
248
159
293
model
model
"SIS" "SIR" "SIRS"
1

SWITCH
24
187
157
220
quarantine?
quarantine?
1
1
-1000

SLIDER
169
256
426
289
average-immunity-time
average-immunity-time
3
20
10
1
1
days
HORIZONTAL

PLOT
21
315
221
465
Infected / continent
ticks
people
0.0
100.0
0.0
30.0
true
true
"" ""
PENS
"USA" 1.0 0 -15575016 true "" "plot count turtles with [ (latent? or rash? or prodromic?) and american? ] * 100 / americans"
"Afr" 1.0 0 -2674135 true "" "plot count turtles with [ (latent? or rash? or prodromic?) and african? ] * 100 / africans"
"Eu" 1.0 0 -14730904 true "" "plot count turtles with [ (latent? or rash? or prodromic?) and european? ] * 100 / europeans"
"Asia" 1.0 0 -7171555 true "" "plot count turtles with [ (latent? or rash? or prodromic?) and asian? ] * 100 / asians"

CHOOSER
23
126
161
171
patient-zero
patient-zero
"american" "asian" "african" "european"
1

PLOT
20
478
220
628
Deaths per continent
ticks
deaths
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -2674135 true "" "plot (count turtles with [ dead? and african? ])  * 100 / africans"
"pen-1" 1.0 0 -15040220 true "" "plot (count turtles with [ dead? and american? ]) * 100 / americans"
"pen-2" 1.0 0 -4079321 true "" "plot (count turtles with [ dead? and asian? ]) * 100 / asians"
"pen-3" 1.0 0 -15390905 true "" "plot (count turtles with [ dead? and european? ]) * 100 / europeans"

MONITOR
740
526
875
571
dead americans
count turtles with [dead? and american?] / americans * 100
2
1
11

MONITOR
992
534
1128
579
dead europeans
count turtles with [dead? and european?] / europeans * 100
2
1
11

MONITOR
1195
533
1314
578
dead africans
count turtles with [dead? and african?] / africans * 100
2
1
11

SLIDER
249
74
462
107
travel-chance-south
travel-chance-south
0
1
0.2
0.1
1
%
HORIZONTAL

CHOOSER
183
127
363
172
separate-n-s
separate-n-s
"yes" "no"
1

PLOT
264
316
464
466
Epidemic model
ticks
people
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -2674135 true "" "plot count turtles with [ latent? ]"
"pen-1" 1.0 0 -16449023 true "" "plot count turtles with [ susceptible? ]"
"pen-2" 1.0 0 -14070903 true "" "plot count turtles with [ cured? or dead? ]"

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
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
NetLogo 5.0.5
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
