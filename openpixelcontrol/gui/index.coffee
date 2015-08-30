ck = require "coffeekup"
express = require 'express'
WebServer = express()

bodyParser = require "body-parser"
urlencodedParser = bodyParser.urlencoded({ extended: false })

port=3456

exec = require("child_process").exec
exec2 = require("child_process").exec


WebServer.listen port, ->
  console.log "listening at #{port}"
  WebServer.get '/' , (req,res)->
    res.send index


  WebServer.post '/create' ,urlencodedParser, (req,res)->
    replaceString = "colors=\\["
    for k,v of req.body
      console.log v
      replaceString+= "\\("
      i = 0
      for x in v
        replaceString+= "#{x}"
        if i < 2
          replaceString+= ","
        else
          replaceString+= "\\)"
        i++
    replaceString+= "\\]"
    re = replaceString.replace /\\\)\\\(/g , "\\\),\\\("
    console.log re
    child = exec "cat ../python_clients/flash.py | sed s/colors=.*/#{re}/ > ../python_clients/customColors.py", (e,o,se)->
      exec2 "python ../python_clients/customColors.py"

html = ->
  div class:"container",->
    link rel:"stylesheet",href:"bundle.css"
    h1 "Choose Colors"
    div class:"picker"
    button class:"colorpick btn btn-default","Choose Color"
    button class:"colorclear btn btn-default","Reset"
    button class:"create btn btn-default","Create"
    h2 "Chosen Colors:"
    div class:"colors"
    script src:"bundle.js"

WebServer.use(express.static 'public')
index = ck.render html
