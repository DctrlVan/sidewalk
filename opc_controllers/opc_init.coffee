Socket = require("net").Socket
socket = new Socket()
socket.setNoDelay()

# Set for localshow - to emulate on local computer graphic
# socket.connect 22000

# Set for sidewalk display - Uncomment below to pump to sidewalk
socket.connect 7890, '192.168.1.99'

createOPCStream = require "opc"
stream = createOPCStream()
stream.pipe(socket)

width = 13
height = 62

createStrand = require "opc/strand"
# This creates an opc strand of (w*h) pixels
strand = createStrand width*height

# For coding convenience we split the strand into column references.
columns = []
i = 0
while i < width
	# Each column can set all of the pixels within that column
	columns.push strand.slice height*i, height*(i+1)
	i++

# to set a pixel you reference by column # and pixel.
# column[<column#>].setPixel <row#> , colorRed, colorG, colorB
# column[2].setPixel 8, 255, 0, 0

module.exports = { height , width , stream , strand , columns }
