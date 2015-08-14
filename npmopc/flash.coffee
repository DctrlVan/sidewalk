Socket = require("net").Socket
socket = new Socket()
socket.setNoDelay()
socket.connect 22000

createOPCStream = require "opc"
stream = createOPCStream()
stream.pipe(socket)

#config for size of display:
width = 13
height = 50

createStrand = require "opc/strand"
strand = createStrand width*height
columns = []
i = 0
while i < width
	columns.push strand.slice height*i, height*(i+1)
	i++

###
^^The columns Array contains parts of the strand.
Can set specific pixels through x/y axis as such:
columns[i].setPixel row, red, green, blue
This is great.
###

#config options for user, defaults?
colors = [[240,50,50],[102,102,51],[204,0,204]]
fill = 50
speed = 50

distort = (color)->
	mod = [0,0,0]
	for c, index in color
		d = Math.random() - .5
		mod[index] = parseInt(c + 123*d)
		if mod[index] > 255 then mod[index] = 255
		if mod[index] < 0 then mod[index] = 0
	return mod


filler = (color, fill)->
	y = 0
	while y < height
		x = 0
		while x < width
			di = distort color
			if Math.random()*100 < fill
				columns[x].setPixel i, di[0],di[1],di[2]
			x++
		y++

flash = (colors, fill, speed)->
	setInterval ->
		filler colors[0], fill
		console.log strand.buffer
		stream.writePixels(0, strand.buffer)
	, 2000

color = [200,50,50]
y = 0
while y < height
	x = 0
	while x < width
		di = distort color
		if Math.random()*100 < fill
			columns[x].setPixel i, di[0],di[1],di[2]
		x++
	y++


setTimeout stream.writePixels(0, strand.buffer), 3000
