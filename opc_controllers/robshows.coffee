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

fullFill [30, 160, 20], 0.5

Testing = ()->
	## colour array to standardise colour
	c = [255, 23, 242]

	## to make longitudinal line in 10th column
	i =0
	while i < height
		columns[10].setPixel(i, 255, 23, 242)
		i++

	## to set a single pixel
	columns[5].setPixel(51, c[0], c[1], c[2])

	## to draw a line along width direction
	j = 0
	while j < width
		columns[j].setPixel(51, c[0], c[1], c[2])
		j++
