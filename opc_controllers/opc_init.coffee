Socket = require("net").Socket
socket = new Socket()
socket.setNoDelay()
socket.connect 22000

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

module.exports = { height , width , stream , strand , columns }
