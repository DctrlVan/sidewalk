cp = require("child_process")
cre = (colors)->
	replaceString = "colors=\\["
	for k,v of colors
		replaceString+= "\\("
		i=0
		for colourVal in v
			replaceString+= "#{colourVal}"
			if i<2
				replaceString+= ","
			else
				replaceString+= "\\)"
			i++
	replaceString+= "\\]"
	return replaceString.replace /\\\)\\\(/g , "\\\),\\\("
spawnPreview = ->
	spawn = cp.spawn
	spawn "../bin/gl_server", ['-l','layouts/sidewalk.json']
runPythonFile = ( file )->
	cp.exec "python #{file}", ->
		console.log "file run ended"
editcolors = (file,colors)->
	#colors regular expression
	re = cre colors
	console.log re
	cp.exec "cat python_clients/#{file} | sed s/colors=.*/#{re}/ > out.py" , (a,b,c)->
		runPythonFile("out.py")


#colors=[[1,2,3],[4,5,6]]
#editcolors "flash.py", colors
#runPythonFile "flash.py"

module.exports = {editcolors, runPythonFile}
