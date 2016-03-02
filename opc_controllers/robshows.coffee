## Rob experimenting with sidewalk
## Notes columns run along the height (the long direction)
## uses i and y for pixels along the height, and j and x for pixels along the width

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
module.exports.grad_long = ()->
	p = 0
	## run this loop on an interval with time specified at end of the loop on same indent
	setInterval ->
		# set i to 0 to initiate loop at zero, i represents position along height
		i = 0
		## run for all positions 0 to height
		while i < height
			## sets g, r, b if 'i' is within the first 3rd of the board
			if i < height / 3
				green = 0
				red = 255 - 255 * ((height / 3) - i) / (height / 3)
				blue = 255 - 255 * i / (height / 3)
				## sets g, r, b if 'i' is within the middle 3rd of the board
			else if i < 2 * height / 3
				green = 255 - 255 * ((2 * height / 3) - i) / (height / 3)
				red = 255 - 255 * (i - (height / 3)) / (height / 3)
				blue = 0;
			else
				## sets g, r, b if 'i' is within the final 3rd of the board
				green = 255 - 255 * (i - (2 * height / 3)) / (height / 3)
				red = 0
				blue  = 255 - 255 * (height - i) / (height / 3)

			## sets the pixel using the green, red and blue values along the width of the board
			j = 0
			## executes loop for all pixels within the width
			while j < width
				## sets the pixel using the green, red and blue values along the width of the board
				columns[j].setPixel((i + p)%62, green, red, blue)
				j++
			i++
		stream.writePixels(0, strand.buffer)
		## increases the p value, moving all pixels down 1 place along the height
		p++
	, 65 ## sets the interval in milliseconds for the loop

#clear_sidewalk()
#grad_long()

## make a ball that moves through the environment based off a vector
Bouncing_Ball = ()->
	## set start position of centre point of ball x is distance along width, y is distance along height
	x = 4.5
	y = 4.5

	# set cushion - distance off edge wall at which centre of the ball will bounce
	# note, make sure start position(above) is within cushion
	cushion = 4

	# set ball size - diameter
	ballsize = 6

	# set colours (0 - 255) for green, red, blue.
	green = 180
	red = 180
	blue = 0

	## draw ball, using loops check all pixels, if not within 1.4 pixels of centre point set c to [0, 0, 0]
	## if within 2 pixels use pythagoris to scale brightness
	Draw_ball = ()->
		## loop through all pixels along height
		i = 0
		while i < height
			## loop through all pixels along width
			j = 0
			while j < width
				## set all pixels which are not within 1/2 * ballsize in height and width directions of centre of ball to off
				if Math.abs(y - i) > (ballsize / 2) or Math.abs(x - j) > (ballsize / 2)
					c = [0, 0, 0]
				else
					## measure distance of the pixel from the centre of the ball
					dist = Math.sqrt((x - j)**2 + (y - i)**2)
					## for pixels within 0.7 pixels of centre of ball set at full brightness
					if dist <= (ballsize / 4)
						c = [green, red, blue]
					## for pixels between 0.7 and 1.4 pixels distance from centre of ball scale between full and zero
					## depending on distance away from centre
					else if dist <= (ballsize / 2)
						clrgradient = ( dist - (ballsize / 4) ) / (ballsize / 4)
						c = [green - green * clrgradient, red - red * clrgradient, blue - blue * clrgradient]
					## if pixel is not within 1.4 pixels of centre of ball set to zero light
					else
						c = [0, 0, 0]
				## set the pixel for its colour
				r = 150; g = 150; b = 150
				if Math.random() < .5
					r += 1
				else
					r -= 1
				if Math.random() < .5
					g += 1
				else
					b -= 1
				if Math.random() < .5
					b += 1
				else
					b -= 1

				check254 = (x)-> if x > 253 then return 100 else	return x
				r = check254 r
				g = check254 g
				b = check254 b

				check0 = (x)->
					if x < 0 then return 100
					return x
				r = check0 r
				g = check0 g
				b = check0 b
				console.log 'setting pixel ', j , i
				columns[j].setPixel(i, r, g, b)
				j++
			i++
		stream.writePixels(0, strand.buffer)
	## set the x and y vectors for how much to move per cycle
	xvect = 0.8
	yvect = 0.4

	## set acceleration vectors for x and y axis, for acceleration per cycle
	xacc = 0.002
	yacc = -0.005

	setInterval ->
		Draw_ball()

		## ball bounce off width axis
		if x < cushion
			xvect = xvect * -1
			xacc = xacc * -1
		else if x > width - cushion
			xvect = xvect * -1
			xacc = xacc * -1
		## ball bounce off height axis
		if y < cushion
			yvect = yvect * -1
			yacc = yacc * -1
		else if y > height - cushion
			yvect = yvect * -1
			yacc = yacc * -1

		## change the centre of ball location based on xvect and yvect
		x = x + xvect
		y = y + yvect

		## change the xvect and yvect values based on xacc and yacc
		xvect = xvect + xacc
		yvect = yvect + yacc

		# optional line to increase ball size
		r = Math.random()
		if r < 0.5
			console.log 'bigger'
			ballsize = ballsize + 0.05
		else
			console.log 'smaller'
			ballsize = ballsize - 0.05

	, 50

Bouncing_Ball()
## draw ball, using loops check all pixels, if not within 1.4 pixels of centre point set c to [0, 0, 0]
## if within 2 pixels use pythagoris to scale brightness


# clear_sidewalk()
# Bouncing_Ball()
