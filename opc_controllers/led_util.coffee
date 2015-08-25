npm_opc = require "./opc_init.coffee"

width = npm_opc.width
height = npm_opc.height
strand = npm_opc.strand
columns = npm_opc.columns
stream = npm_opc.stream

clear = ->
	y = 0
	while y < height
		x = 0
		while x < width
			columns[x].setPixel y,0,0,0
			x++
		y++


module.exports = { clear }
