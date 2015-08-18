ck = require "coffeekup"
express = require 'express'
WebServer = express()

bodyParser = require "body-parser"
urlencodedParser = bodyParser.urlencoded({ extended: true })

port=3456

shows = require "./opc_controllers/shows.coffee"
tetris = require "./opc_controllers/tetris.js"

lightshow = null

WebServer.listen port, ->
  console.log "listening at #{port}"
  WebServer.get '/' , (req,res)->
    res.send indexHtml

  WebServer.post '/startshow', urlencodedParser, (req,res)->
    if lightshow? then clearInterval lightshow
    if cycle? then clearInterval cycle
    console.log "New show request: ", req.body
    if !req.body.colorArray?
      req.body.colorArray = [[255,0,0],[0,255,0],[0,0,255]]
    switch req.body.show
      when "Rainbow Rows"
        lightshow = shows.rainbowShow req.body.colorArray, .33, 1111
      when "Rave Lights"
        lightshow = shows.flashShow req.body.colorArray, .19, 111
      when "Waves"
        lightshow = shows.waveShow req.body.colorArray, 3, 25
      when "Chill"
        lightshow = shows.sinShow req.body.colorArray
      when "Tetris"
        lightshow = tetris()
      when "Cycle"
        lightshow = cycleShows()
    res.send "dance party"

indexTemplate = ->
  div class:"container",->
    link rel:"stylesheet",href:"bundle.css"
    h1 "DECENTRAL"
    h1 "VANCOUVER"
    h1 "SIDEWALK CONTROLLER"
    div class:'Color_Picker', ->
        div class:"colors", ->
          span class:'colorPick'
        div class:"picker", ->
          button class:"clearcolor btn btn-default btn-md","Reset"
    div class:'submitButtons', ->
      button class:'btn btn-primary btn-lg col-xs-6',  "Rainbow Rows"
      button class:'btn btn-primary btn-lg col-xs-6',  "Rave Lights"
      button class:'btn btn-primary btn-lg col-xs-6',  "Waves"
      button class:'btn btn-primary btn-lg col-xs-6',  "Chill"
      button class:'btn btn-primary btn-lg col-xs-12', "Cycle"
      button class:'btn btn-primary btn-lg col-xs-12', "Tetris"
    script src:"bundle.js"

indexHtml = ck.render indexTemplate

WebServer.use(express.static 'public')
