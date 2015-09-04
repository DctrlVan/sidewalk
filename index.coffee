ck = require "coffeekup"
express = require 'express'
WebServer = express()

bodyParser = require "body-parser"
urlencodedParser = bodyParser.urlencoded({ extended: true })

port=3456

shows = require "./opc_controllers/shows.coffee"
tetris = require "./opc_controllers/tetris.js"
writer = require "./opc_controllers/alphabet.coffee"

lightshow = null

WebServer.listen port, ->
  console.log "listening at #{port}"
  WebServer.get '/' , (req,res)->
    res.send indexHtml

  WebServer.post '/startshow', urlencodedParser, (req,res)->
    if lightshow?
      clearInterval lightshow
      tetris.breakInterval()
    if cycle? then clearInterval cycle
    console.log "New show request: ", req.body
    if !req.body.colorArray?
      req.body.colorArray = [[255,0,0],[0,255,0],[0,0,255]]
    switch req.body.show
      when "Chill"
        lightshow = shows.rainbowShow req.body.colorArray, .33, 1111
      when "Rave Lights"
        lightshow = shows.flashShow req.body.colorArray, .19, 111
      when "Arrows"
        lightshow = shows.arrowShow req.body.colorArray, 25
      when "DNA"
        lightshow = shows.sinShow req.body.colorArray
      when "Tetris"
        localshow = tetris.interval()
        T = tetris.init  req.body.colorArray
      when "Cycle"
        lightshow = cycleShows()
      when "Banner"
        if !req.body.banner?
          req.body.banner = "banner"
        lightshow = writer.longBanner req.body.banner.toUpperCase(), req.body.colorArray
    res.sendStatus 200

  WebServer.get '/tetris/:player/:direction', (req,res) ->
    movement = String req.params.direction.split(" ")[0]
    if req.params.player == "red"
      tetris.redMove movement
    if req.params.player == "blue"
      tetris.blueMove movement
    res.sendStatus 200

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
      button class:'btn btn-primary btn-lg col-xs-6',  "Chill"
      button class:'btn btn-primary btn-lg col-xs-6',  "Rave Lights"
      button class:'btn btn-primary btn-lg col-xs-6',  "Arrows"
      button class:'btn btn-primary btn-lg col-xs-6',  "DNA"
      button class:'btn btn-primary btn-lg col-xs-6',  "Banner"
      div class:'col-xs-6', ->
        input class:'banner', type:'text'
    button class:'tetrisButton btn btn-primary btn-lg col-xs-12', ->
      text 'Tetris'
    div class:'tetrisControls col-xs-12 red', ->
      div class:'ROTATE' , ->
        i class:"glyphicon glyphicon-refresh col-xs-12"
      div class:'LEFT' , ->
        i class:"glyphicon glyphicon-arrow-left col-xs-6"
      div class:'RIGHT', ->
        i class:"glyphicon glyphicon-arrow-right col-xs-6"
      div class: 'DOWN' , ->
        i class:"glyphicon glyphicon-arrow-down col-xs-12"
    div class:'tetrisControls col-xs-12 blue', ->
      div class:'ROTATE' , ->
        i class:"glyphicon glyphicon-refresh col-xs-12"
      div class:'LEFT' , ->
        i class:"glyphicon glyphicon-arrow-left col-xs-6"
      div class:'RIGHT', ->
        i class:"glyphicon glyphicon-arrow-right col-xs-6"
      div class: 'DOWN' , ->
        i class:"glyphicon glyphicon-arrow-down col-xs-12"

  script src:"bundle.js"

indexHtml = ck.render indexTemplate

WebServer.use(express.static 'public')
