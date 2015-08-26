npm_opc = require "./opc_init.coffee"

width = npm_opc.width
height = npm_opc.height
strand = npm_opc.strand
columns = npm_opc.columns
stream = npm_opc.stream

ledUtil = require "./led_util.coffee"

alphabet =
  A:[
    [0,1,1,1,0]
    [1,0,0,0,1]
    [1,1,1,1,1]
    [1,0,0,0,1]
    [1,0,0,0,1]
  ]
  B:[
    [1,1,1,1,0]
    [1,0,0,0,1]
    [1,1,1,1,0]
    [1,0,0,0,1]
    [1,1,1,1,0]
  ]
  C:[
    [0,1,1,1,1]
    [1,0,0,0,0]
    [1,0,0,0,0]
    [1,0,0,0,0]
    [0,1,1,1,1]
  ]
  D:[
    [1,1,1,1,0]
    [1,0,0,0,1]
    [1,0,0,0,1]
    [1,0,0,0,1]
    [1,1,1,1,0]
  ]
  E:[
    [1,1,1,1,1]
    [1,0,0,0,0]
    [1,1,1,1,0]
    [1,0,0,0,0]
    [1,1,1,1,1]
  ]
  F:[
    [1,1,1,1,1]
    [1,0,0,0,0]
    [1,1,1,1,0]
    [1,0,0,0,0]
    [1,0,0,0,0]
  ]
  G:[
    [0,1,1,1,0]
    [1,0,0,0,0]
    [1,0,1,1,1]
    [1,0,0,0,1]
    [0,1,1,1,0]
  ]
  H:[
    [1,0,0,0,1]
    [1,0,0,0,1]
    [1,1,1,1,1]
    [1,0,0,0,1]
    [1,0,0,0,1]
  ]
  I:[
    [1,1,1,1,1]
    [0,0,1,0,0]
    [0,0,1,0,0]
    [0,0,1,0,0]
    [1,1,1,1,1]
  ]
  J:[
    [1,1,1,1,1]
    [0,0,0,0,1]
    [0,0,0,0,1]
    [1,0,0,0,1]
    [0,1,1,1,0]
  ]
  K:[
    [1,0,0,0,1]
    [1,0,0,1,0]
    [1,1,1,0,0]
    [1,0,0,1,0]
    [1,0,0,0,1]
  ]
  L:[
    [1,0,0,0,0]
    [1,0,0,0,0]
    [1,0,0,0,0]
    [1,0,0,0,0]
    [1,1,1,1,1]
  ]
  M:[
    [0,1,0,1,1]
    [1,0,1,0,1]
    [1,0,1,0,1]
    [1,0,0,0,1]
    [1,0,0,0,1]
  ]
  N:[
    [1,0,0,0,1]
    [1,1,0,0,1]
    [1,0,1,0,1]
    [1,0,0,1,1]
    [1,0,0,0,1]
  ]
  O:[
    [1,1,1,1,1]
    [1,0,0,0,1]
    [1,0,0,0,1]
    [1,0,0,0,1]
    [1,1,1,1,1]
  ]
  P:[
    [1,1,1,1,1]
    [1,0,0,0,1]
    [1,1,1,1,1]
    [1,0,0,0,0]
    [1,0,0,0,0]
  ]
  Q:[
    [1,1,1,1,1]
    [1,0,0,0,1]
    [1,1,1,1,1]
    [0,0,0,0,1]
    [0,0,0,0,1]
  ]
  R:[
    [1,1,1,1,0]
    [1,0,0,0,1]
    [1,1,1,1,0]
    [1,0,0,0,1]
    [1,0,0,0,1]
  ]
  S:[
    [0,1,1,1,1]
    [1,0,0,0,0]
    [0,1,1,1,0]
    [0,0,0,0,1]
    [1,1,1,1,0]
  ]
  T:[
    [1,1,1,1,1]
    [0,0,1,0,0]
    [0,0,1,0,0]
    [0,0,1,0,0]
    [0,0,1,0,0]
  ]
  U:[
    [1,0,0,0,1]
    [1,0,0,0,1]
    [1,0,0,0,1]
    [1,0,0,0,1]
    [1,1,1,1,1]
  ]
  V:[
    [1,0,0,0,1]
    [1,0,0,0,1]
    [1,0,0,0,1]
    [0,1,0,1,0]
    [0,0,1,0,0]
  ]
  W:[
    [1,0,1,0,1]
    [1,0,1,0,1]
    [1,0,1,0,1]
    [1,0,1,0,1]
    [1,1,1,1,1]
  ]
  X:[
    [1,0,0,0,1]
    [0,1,0,1,0]
    [0,0,1,0,0]
    [0,1,0,1,0]
    [1,0,0,0,1]
  ]
  Y:[
    [1,0,0,0,1]
    [1,0,0,0,1]
    [1,1,1,1,1]
    [0,0,1,0,0]
    [0,0,1,0,0]
  ]
  Z:[
    [1,1,1,1,1]
    [0,0,0,0,1]
    [0,1,1,1,0]
    [1,0,0,0,0]
    [1,1,1,1,1]
  ]
  " ":[
    [0,0,0,0,0]
    [0,0,0,0,0]
    [0,0,0,0,0]
    [0,0,0,0,0]
    [0,0,0,0,0]
  ]

horizontalLetter = (Yposition, Xposition ,letter, r, g, b)->
  for columnArray, Yindex in alphabet[letter]
    for pixel, Xindex in columnArray
      j = Yindex + Yposition
      i = Xindex + Xposition
      if pixel==1
        columns[j].setPixel(i,r,g,b)
      else
        columns[j].setPixel(i,0,0,0)

verticalLetter = (Yposition, Xposition ,letter, r, g, b)->
  for columnArray, Xindex in alphabet[letter]
    for pixel, Yindex in columnArray
      j = Yindex + Yposition
      i = Xindex + Xposition
      if pixel==1
        columns[j].setPixel(i,r,g,b)
      else
        columns[j].setPixel(i,0,0,0)

#NINE LETTER MAX (TODO:Handle longer strings)
topHorizontalWord = (start, word, r, g, b)->
  x = 1
  for letter, index in word
    y = (start + (6*index)) % 57
    horizontalLetter(x,y,letter,r,g,b)

#NINE LETTER MAX (TODO:Handle longer strings)
banner = (word, r, g, b)->
  start = 0
  setInterval ->
    topHorizontalWord(start,word,200,33,50)
    stream.writePixels(0, strand.buffer);
    ledUtil.clear()
    start++
  , 323

scrollText = (phrase, r, g, b)->
  x = 1
  length = phrase.length
  i = 0
  setInterval ->
    if i > length-8 then i = 0
    visible = phrase[(length-10)-i...length-i]
    topHorizontalWord(x,visible,r,g,b)
    stream.writePixels(0, strand.buffer);
    ledUtil.clear()
    i++
  , 323

module.exports =  { banner , scrollText }
