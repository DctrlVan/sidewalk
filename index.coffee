ck = require "coffeekup"
express = require 'express'
WebServer = express()

bodyParser = require "body-parser"
urlencodedParser = bodyParser.urlencoded({ extended: true })

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

  WebServer.get '/getpicker' , (req,res)->
    res.send colorpickerHtml

  WebServer.post '/create' ,urlencodedParser, (req,res)->
    console.log req.body
    lights.createflash "flash.py", req.body
    #create


###
The menu module takes a json document and outputs
the html of a menu
###
menu = require "./templates/menu.coffee"
menuDoc =
  _title:"Sidewalk"
  flashy:
    Color_Picker:'custom'
    Flash_Speed:'range'
    Fill_Percent:'range'
  Lava_Lamp:
    Contemplation:'range'
    Insignificance:'range'
    Joy:'range'
  _ranges:{}
  _lists:{}
menuHtml = menu menuDoc

picker = ->
  div class:"picker"
  div ".col-xs-12",->
    button class:"clearcolor btn btn-default","Reset"
  div class:"colors"
colorpickerHtml = ck.render picker

html = ->
  div class:"container",->
    link rel:"stylesheet",href:"bundle.css"
    div class:"title", ->
      h1 "DECENTRAL"
      h1 "VANCOUVER"
      text menuHtml
    script src:"bundle.js"

WebServer.use(express.static 'public')
index = ck.render html, locals:{menuHtml}
