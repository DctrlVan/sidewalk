Socket = require("net").Socket
socket = new Socket()
socket.setNoDelay()
socket.connect 22000

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
while i < height
	j = 0
	while j < width
		switch j%3
			when 0
				columns[j].setPixel i, 155,30,33
			when 1
				columns[j].setPixel i, 155,199,33
			when 2
				columns[j].setPixel i, 1,30,233
		j++
	i++
	#left.setPixel(i, 255, 0, 0)
	#right.setPixel(i, 0, 0, 255)

stream.writePixels(0, strand.buffer);
