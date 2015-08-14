Socket = require("net").Socket
socket = new Socket()
socket.setNoDelay()
socket.connect 7890

createOPCStream = require "opc"
stream = createOPCStream()
stream.pipe(socket)


width = 13
height = 50

createStrand = require "opc/strand"
strand = createStrand width*height

columns = []
i = 0
while i < width
	columns.push strand.slice height*i, height*(i+1)
	i++

i = 0

colorColumns = (colors, fill)->
	i = 0
	j = 0
	l = colors.length
	console.log l
	while i < height
		while j < width
			d = Math.random()
			if d < fill
				ci = j%l
				columns[j].setPixel i, colors[ci][0],colors[ci][1],colors[ci][2]
			else
				columns[j].setPixel i,0,0,0
			j++
		i++
		console.log i
		#left.setPixel(i, 255, 0, 0)
		#right.setPixel(i, 0, 0, 255)

colors = [[233,3,4],[12,233,23]]

setInterval ->
	colorColumns(colors, .5)
	stream.writePixels 0, strand.buffer
, 5000
