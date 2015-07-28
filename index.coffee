ck = require "coffeekup"
express = require 'express'
WebServer = express()

bodyParser = require "body-parser"
urlencodedParser = bodyParser.urlencoded({ extended: false })

port=3456

lights = require "./python_clients/editScripts.coffee"

###
#Start a sidewalk light preview pane:
execPreview = require("child_process").spawn
preview = execPreview "./bin/gl_server -l python_clients/layouts/sidewalk.json"
###

WebServer.listen port, ->
  console.log "listening at #{port}"
  WebServer.get '/' , (req,res)->
    res.send index

  WebServer.post '/create' ,urlencodedParser, (req,res)->
    console.log req.body
    lights.editcolors "flash.py", req.body
    #create

html = ->
  div class:"container",->
    link rel:"stylesheet",href:"bundle.css"
    h1 "Choose Colors"
    div class:"picker"
    button class:"pickcolor btn btn-default","Choose Color"
    button class:"clearcolor btn btn-default","Reset"
    button class:"create btn btn-default","Create"
    h2 "Chosen Colors:"
    div class:"colors"
    script src:"bundle.js"

WebServer.use(express.static 'public')
index = ck.render html
