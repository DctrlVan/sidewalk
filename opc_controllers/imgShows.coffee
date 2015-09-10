
npm_opc = require "./opc_init.coffee"
width = npm_opc.width
height = npm_opc.height
strand = npm_opc.strand
columns = npm_opc.columns
stream = npm_opc.stream

#list the names of the shows here, and the the number of frames:
gifShowNames =
	orangeDot:10

shows = {}

for showName, frames of gifShowNames
	i = 1
	shows[showName] = []
	while i <= frames
		shows[showName].push (require "./Gallery/#{showName}/coffee/#{i}.coffee")
		i++

ledUtil = require "./led_util.coffee"
frame = 0

runShow = (showName , speed)->
	showLength = shows[showName].length
	console.log 'showlength:    ' , showLength
	frame = 0
	setInterval ->
		pixel = 0
		y = height-1
		while y >= 0
			x = 0
			while x < width
				di = shows[showName][frame][pixel]
				if di?
					columns[x].setPixel y, di[0],di[1],di[2]
					pixel++
				x++
			y--
		frame = (frame + 1) % showLength
		stream.writePixels(0, strand.buffer)
		ledUtil.clear()
	, speed

runShow 'orangeDot', 25

module.exports = { gifShowNames }
