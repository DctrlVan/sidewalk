cp = require("child_process")
cre = (colours)->
	replaceString = "colours=\\[" 
	for colourCode in colours
		replaceString+= "\\("
		i=0
		for colourVal in colourCode
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
editColours = (file, colors)->
	#colors regular expression
	re = cre colors
	cp.exec "cat #{file} | sed s/colors=.*/#{re}/ > #{file}"


colours = [[0,250,50]]
spawnPreview()
editColours "customRave.py", colours
runPythonFile "customRave.py"
