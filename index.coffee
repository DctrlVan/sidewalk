ck = require "coffeekup"
express = require 'express'
WebServer = express()

bodyParser = require "body-parser"
urlencodedParser = bodyParser.urlencoded({ extended: false })

port=3456

execSed = require("child_process").exec
execOut = require("child_process").exec

###
#Start a sidewalk light preview pane:
execPreview = require("child_process").spawn
preview = execPreview "./bin/gl_server -l python_clients/layouts/sidewalk.json"
###

WebServer.listen port, ->
  console.log "listening at #{port}"
  WebServer.get '/' , (req,res)->
    res.send index

  WebServer.post '/createRave' ,urlencodedParser, (req,res)->
    replaceString = "colors=\\["
    timeout = 5000 #set this from payout.
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
    execSed "cat python_clients/customRave.py | sed s/colors=.*/#{re}/ > python_clients/out.py", (e,o,se)->
      execOut "python python_clients/out.py"

html = ->
  div class:"container",->
    link rel:"stylesheet",href:"bundle.css"


		h1 "Choose Colors"
    div class:"picker"
    button class:"pickcolor btn btn-default","Choose Color"
    button class:"clearcolor btn btn-default","Reset"
    button class:"createRave btn btn-default","Create"
    h2 "Chosen Colors:"
    div class:"colors"
    script src:"bundle.js"

WebServer.use(express.static 'public')
index = ck.render html
