## Rob experimenting with sidewalk

npm_opc = require "./opc_init.coffee"

width = npm_opc.width
height = npm_opc.height
strand = npm_opc.strand
columns = npm_opc.columns
stream = npm_opc.stream

fullFill = (di, fill)->
	y = 0
	while y < height
		x = 0
		while x < width
			if Math.random() < fill
				columns[x].setPixel y, (di[1]+10*y*x)%250,(di[1]+4*y*x)%250,(di[1]+1*y*x)%250
			else
				columns[x].setPixel y,0,0,0
			x++
		y++
	stream.writePixels(0, strand.buffer)

# fullFill [30, 160, 20], 0.5

Testing = ()->
	## Clear sidewalk
	y = 0
	while y < height
		x = 0
		while x < width
			columns[x].setPixel y,0,0,0
			x++
		y++

	## colour array to standardise colour
	c = [155, 155, 155]

	## to make longitudinal line in 10th column
	i =0
	while i < height
		columns[10].setPixel(i, 255, 23, 242)
		i++

	## to set a single pixel
	columns[5].setPixel(25, c[0], c[1], c[2])

	## to draw a line along width direction
	j = 0
	while j < width
		columns[j].setPixel(51, c[0], c[1], c[2])
		j++
	stream.writePixels(0, strand.buffer)

# Testing()

## make a colour gradient accross the width using 2 coulours going from one to the other
clr_grad = ()->
	## Clear sidewalk
	y = 0
	while y < height
		x = 0
		while x < width
			columns[x].setPixel y,0,0,0
			x++
		y++

	j = 0
	while j < width
		red = 255
		green = 0
		blue = 255
		## not [R, G, B] but [G, R, B]
		c = [red * j / width, green, blue * (width - j) / width]

		## to make one longitudinal line
		i = 0
		while i < height
			columns[j].setPixel(i, c[1], c[2], c[0])
			i++
		j++
	stream.writePixels(0, strand.buffer)

# clr_grad()
clear_sidewalk = () ->
	## Clear sidewalk
	y = 0
	while y < height
		x = 0
		while x < width
			columns[x].setPixel y,0,0,0
			x++
		y++

## 3 colour grad length
grad_long = ()->
	i = 0
	while i < height
		red = 255 - 255 * Math.abs((height / 3) - i ) / ( height / 3 )
		if red < 0
			red = 0
		if i < (height * 2 / 3)
			green = 255 - 255 * ((2 * height / 3) - i) / (height / 3)
		if i > (height * 2 / 3)
			green = 255 - 255 * (i - (2 * height / 3)) / (height / 3)
		if green < 0
			green = 0
		## green = 255 - 255 * Math.abs((height * 2 / 3) - i ) / ( height / 3 )
		if i < height / 3
			blue = 255 - 255 * i / (height / 3)
		if i > 2 * height / 3
			blue = 255 - 255 * (height - i) / (height / 3)
		## not [R, G, B] but [G, R, B]
		## to make the

		## to make one width line
		j = 0
		while j < width
			columns[j].setPixel(i, green, red, blue)
			j++
		i++
	stream.writePixels(0, strand.buffer)

clear_sidewalk()
grad_long()

sinShow = (colors)->
	l = colors.length
	j = 0
	position = 0
	setInterval ->
		ci = j%(l-1)
		splitSinWave(colors[ci],colors[ci+1] , position)
		stream.writePixels(0, strand.buffer)
		position++
		if position > 1000 then position = 0
		if position%50 == 0
			j++
			if j > 1000 then j = 0
	, 200



## make a ball that moves through the environment based off a vector
Bouncing_Ball = ()->
	## standard colour
	c = [155, 155, 155]

	## move a point based off an acceleration vector of 5y and 3x per second
	y
