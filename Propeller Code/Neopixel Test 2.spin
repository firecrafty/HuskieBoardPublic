{Object_Title_and_Purpose}


CON
        _clkmode = xtal1 + pll16x                                               'Standard clock mode * crystal frequency = 80 MHz
        _xinfreq = 5_000_000


        NUMCHANNELS = 5
        
        BRIGHTNESS = 100
        
VAR
  long RED, ORANGE, YELLOW, GREEN, BLUE, PURPLE, BLACK, WHITE
  long HUSKIEORANGE, HUSKIEBLUE 
  byte ch
  byte PIN,LENGTH
  byte strinpt
  long pointer
  long neopixels[64]
  long colors[6], colors2[12]
  long stack[512]
  byte channels[NUMCHANNELS]

  ''BOOLEANS
  byte isFlashingOnOff
  byte isFlashingGreen
  byte isEnabled
  byte stop
OBJ
  neo : "Neopixel Driver"
  pst : "Parallax Serial Terminal"
  str : "String"
  rand: "RealRandom"
PUB init(pin_,length_,pointer_)
  PIN := pin_
  LENGTH := length_
  pointer := pointer_
  isEnabled := false
  isFlashingOnOff := false
  isFlashingGreen := false
  stop := false
  cognew(main,@stack[0])
PUB main   | c, x, in
  neo.start(PIN,LENGTH)
  'pst.start(115_200)
  rand.start

  setColors 

  'waitcnt(cnt+clkfreq*2)
  repeat while !stop
  
  stripes
  {
  METHOD LIST:

  shade
  gradient
  bounce
  center
  rainbow
  stripes
  random
  }
PUB activemode
  isEnabled := true
PUB set20secsLeft
  isFlashingOnOff := true

PRI shade  | c
  c := 0
  repeat
    neo.fill(0,64,colors2[c])
    c++
    if c > 11
      c := 0
    waitcnt(cnt+clkfreq/2)
    
PRI gradient | r,g,b,freq
  freq := 9
  repeat
    r := 255
    g := 0
    b := 0
    repeat g from 0 to 255
      neo.fill(0,64,neo.colorx(r,g,b,BRIGHTNESS))
      waitcnt(cnt+clkfreq/freq)
    repeat r from 255 to 0
      neo.fill(0,64,neo.colorx(r,g,b,BRIGHTNESS))
      waitcnt(cnt+clkfreq/freq)
    repeat b from 0 to 255
      neo.fill(0,64,neo.colorx(r,g,b,BRIGHTNESS))
      waitcnt(cnt+clkfreq/freq)
    repeat g from 255 to 0
      neo.fill(0,64,neo.colorx(r,g,b,BRIGHTNESS))
      waitcnt(cnt+clkfreq/freq)
    repeat r from 0 to 255
      neo.fill(0,64,neo.colorx(r,g,b,BRIGHTNESS))
      waitcnt(cnt+clkfreq/freq)
    repeat b from 255 to 0
      neo.fill(0,64,neo.colorx(r,g,b,BRIGHTNESS))
      waitcnt(cnt+clkfreq/freq)
PRI stripes | offset, x, i
  offset := 0
  repeat
    repeat x from 0+offset to 64+offset
      repeat i from 0 to 3
        neo.set(limit(x+i),ORANGE)
      repeat i from 4 to 7
        neo.set(limit(x+i),BLUE)
      'neo.fill(limit(x),limit(x+3),ORANGE)
      'neo.fill(limit(x+4),limit(x+7),BLUE)
      x+=7
    offset++
    if offset > 64
      offset := 0
    waitcnt(cnt+clkfreq/10)
PRI limit(i) : val
  if i < 0
    i := 64-i
    return i
  elseif i > 64
    i := i-64
    return i
  return i  
PRI center | c, x
  c := 0
  repeat
    repeat x from 0 to 32
      neo.set(x,colors[c])
      neo.set(LENGTH-x, colors[c])
      waitcnt(cnt+clkfreq/50)
    c++
    if c == 6
      c := 0
PRI bounce | c,x
  c := 0
  repeat
    repeat x from 0 to 64
      neo.set(x,colors[c])
      neo.set(LENGTH-x, colors[c-2])
      waitcnt(cnt+clkfreq/50)
    c++
    if c == 6
      c := 0
PRI rainbow | x, i
  channels[0] := 64
  repeat x from 1 to NUMCHANNELS
    channels[x] := channels[x-1]-12
  repeat
    repeat i from 0 to NUMCHANNELS
      ch := channels[i]
      repeat x from ch to ch-11
        if testCh(x)  
          neo.set(x,colors[ch-x])
      channels[i] := ch+1
      if channels[i]-1 > LENGTH
        channels[i] := 0
    waitcnt(cnt+clkfreq/10)
PRI random | x 
  repeat
    repeat x from 0 to 64
      neo.set(x,neo.colorx(rand.random*255,rand.random*255,rand.random*255,BRIGHTNESS))
    waitcnt(cnt+clkfreq/10) 
PRI testCh(channel)
  return (ch =< 64 and ch => 0)
PRI setColors | x , r, g, b, in
  RED := neo.colorx(255,0,0,BRIGHTNESS)
  ORANGE := neo.colorx(255,136,0,BRIGHTNESS)
  YELLOW :=  neo.colorx(255,255,0,BRIGHTNESS)
  GREEN := neo.colorx(0,255,0,BRIGHTNESS)
  BLUE := neo.colorx(0,0,255,BRIGHTNESS)
  PURPLE :=  neo.colorx(187,0,255,BRIGHTNESS)
  BLACK := neo.colorx(0,0,0,BRIGHTNESS)
  WHITE := neo.colorx(255,255,255,BRIGHTNESS)
  HUSKIEORANGE := neo.colorx(230,92,0,BRIGHTNESS)
  HUSKIEBLUE := neo.colorx(6,0,120,BRIGHTNESS)
  colors[0] := RED
  colors[1] := ORANGE
  colors[2] := YELLOW
  colors[3] := GREEN
  colors[4] := BLUE
  colors[5] := PURPLE

  colors2[0] := RED
  colors2[1] := neo.colorx(255,85,0,BRIGHTNESS)
  colors2[2] := neo.colorx(255,145,0,BRIGHTNESS)
  colors2[3] := neo.colorx(255,204,0,BRIGHTNESS)
  colors2[4] := neo.colorx(217,255,0,BRIGHTNESS)
  colors2[5] := neo.colorx(140,255,0,BRIGHTNESS)
  colors2[6] := neo.colorx(0,255,17,BRIGHTNESS)
  colors2[7] := neo.colorx(0,255,34,BRIGHTNESS)
  colors2[8] := neo.colorx(0,255,255,BRIGHTNESS)
  colors2[9] := neo.colorx(0,4,255,BRIGHTNESS)
  colors2[10]:= neo.colorx(98,0,255,BRIGHTNESS)
  colors2[11]:= neo.colorx(255,0,221,BRIGHTNESS)
 
DAT
name    byte  "string_data",0        
        