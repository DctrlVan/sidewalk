Socket = require("net").Socket
socket = new Socket()
socket.setNoDelay()
socket.connect 7890

createOPCStream = require "opc"
stream = createOPCStream()
stream.pipe(socket)

width = 13
height = 63

createStrand = require "opc/strand"
strand = createStrand width*height

columns = []
i = 0
while i < width
	columns.push strand.slice height*i, height*(i+1)
	i++

colors = [[233,33,55],[23,235,83]]
fill = .3

distort = (color)->
	mod = [0,0,0]
	for c, index in color
		d = Math.random() - .5
		mod[index] = parseInt(c) + parseInt(100*d)
		if mod[index] > 255 then mod[index] = 255
		if mod[index] < 0 then mod[index] = 0
	return mod

bycolumns = (colors, fill)->
	l = colors.length
	i = 0
	while i < height
		j = 0
		while j < width
			d = Math.random()
			if d < fill
				ci = j%l
				di = distort colors[ci]
				columns[j].setPixel i, di[0],di[1],di[2]
			else
				columns[j].setPixel i,0,0,0
			j++
		i++

fullFill = (color, fill)->
	y = 0
	while y < height
		x = 0
		while x < width
			if Math.random() < fill
				di = distort color
				columns[x].setPixel y, di[0],di[1],di[2]
			else
				columns[x].setPixel y,0,0,0
			x++
		y++

wave = (color,position)->
	y = 0
	while y < height
		x = 0
		while x < width
			di = color
			if 0 < (y - position) < 5
				columns[x].setPixel y, di[0],di[1],di[2]
			else
				columns[x].setPixel y,0,0,0
			x++
		y++

waveShow = (colors)->
	l = colors.length
	j = 0
	setInterval ->
		j++
		position = j%height
		console.log position
		wave([218,165,32], position)
		stream.writePixels(0, strand.buffer)
	, 10

splitSinWave = (color, position)->
	y = 0
	while y < height
		x = 0
		while x < width
			di = color
			xx = (6.5 * Math.sin((y + position)/5) + 6.5)
			if -.5 < xx - x < .5
				columns[x].setPixel y, di[0],di[1],di[2]
			else
				columns[x].setPixel y,0,0,0
			x++
		y++

sinShow = (colors)->
	l = colors.length
	j = 0
	position = 0
	setInterval ->
		console.log 'sintest'
		ci = j%l
		splitSinWave(colors[ci], position)
		stream.writePixels(0, strand.buffer)
		position = position + 2
		if position%50 == 0
			j++
	, 100

sinShow(colors)

rainbowShow = (colors,fill,speed)->
	setInterval ->
		bycolumns(colors,fill)
		stream.writePixels(0, strand.buffer)
	, speed

flashShow = (colors, fill, speed)->
	l = colors.length
	j = 0
	setInterval ->
		ci = j%l
		console.log ci , colors[ci]
		fullFill colors[ci], fill
		stream.writePixels(0, strand.buffer)
		j++
	, speed
