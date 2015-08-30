npm_opc = require "./opc_init.coffee"

width = npm_opc.width
height = npm_opc.height
strand = npm_opc.strand
columns = npm_opc.columns
stream = npm_opc.stream

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
				columns[j].setPixel i, di[1],di[0],di[2]
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
				columns[x].setPixel y, di[1],di[0],di[2]
			else
				columns[x].setPixel y,0,0,0
			x++
		y++

strip = (color,position, size)->
	y = 0
	while y < height
		x = 0
		while x < width
			di = color
			if 0 < (y - position) < size
				columns[x].setPixel y, di[1],di[0],di[2]
			else
				columns[x].setPixel y,0,0,0
			x++
		y++

arrow = (color,position)->
	y = 0
	while y < height
		x = 0
		while x < width
			di = color
			rel = y - position
			if rel < 0
				columns[parseInt width/2].setPixel y, di[1],di[0],di[2]
			if x > rel and width - x > rel and rel > 0
				columns[x].setPixel y, di[1],di[0],di[2]
			else
				columns[x].setPixel y,0,0,0
			x++
		y++


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
		ci = j%l
		splitSinWave(colors[ci], position)
		stream.writePixels(0, strand.buffer)
		position++
		if position > 1000 then position = 0
		if position%50 == 0
			j++
			if j > 1000 then j = 0
	, 200

waveShow = (colors, speed)->
	l = colors.length
	j = 0
	c = 0
	setInterval ->
		position = j%height
		if position == height - 1
			c++
		ci = c%l
		arrow(colors[ci], position)
		stream.writePixels(0, strand.buffer)
		j++
		if j > 1000 then j = 0
	, speed

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
		fullFill colors[ci], fill
		stream.writePixels(0, strand.buffer)
		j++
		if j > 1000 then j = 0
	, speed

cycleShows = ->
	#

module.exports = { rainbowShow, flashShow , waveShow, sinShow, cycleShows}
