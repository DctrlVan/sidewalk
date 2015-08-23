ck = require "coffeekup"
express = require 'express'
WebServer = express()

bodyParser = require "body-parser"
urlencodedParser = bodyParser.urlencoded({ extended: true })

port=3456

shows = require "./opc_controllers/shows.coffee"
tetris = require "./opc_controllers/tetris.js"

tetrising = off
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
        if not tetrising
          tetris.init()
        tetrising = on
      when "Cycle"
        lightshow = cycleShows()
    res.send "dance party"

  WebServer.get '/tetris/:direction', (req,res) ->
    console.log req.params.direction.split(" ")[0]
    tetris.move(String req.params.direction.split(" ")[0])
    res.send "tetrising!"

indexTemplate = ->
  head ->
    title 'Sidewalk Controller'
    meta name: 'viewport', content: 'width=device-width,
    initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'
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

    button class:'tetrisButton btn btn-primary btn-lg col-xs-12', ->
      text 'Tetris'
    div class:'tetrisControls col-xs-12', ->
      div class: 'ROTATE col-xs-12' , ->
        text '<->'
      div class:'RIGHT col-xs-6' , ->
        text '<-'
      div class:'LEFT col-xs-6', ->
        text '->'
  script src:"bundle.js"

indexHtml = ck.render indexTemplate

WebServer.use(express.static 'public')
