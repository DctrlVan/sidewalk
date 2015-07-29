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

title="Sidewalk"
menuDoc =
  flashy:
    Color_Picker:'custom'
    Epilepticity:'range'
  auroray:
    Contemplation:'range'
    Insignificance:'range'
    Joy:'range'

menu = require "./templates/menu.coffee"
menuHtml = menu title, menuDoc
html = ->
  div class:"container",->
    link rel:"stylesheet",href:"bundle.css"
    div class:"title", ->
      h1 "DECENTRAL"
      h1 "VANCOUVER"
      text menuHtml
    script src:"bundle.js"

WebServer.use(express.static 'public')
index = ck.render html, locals:{title,menuHtml}
