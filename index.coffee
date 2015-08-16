ck = require "coffeekup"
express = require 'express'
WebServer = express()

bodyParser = require "body-parser"
urlencodedParser = bodyParser.urlencoded({ extended: true })

port=3456

shows = require "./opc_controllers/shows.coffee"

lightshow = null

WebServer.listen port, ->
  console.log "listening at #{port}"
  WebServer.get '/' , (req,res)->
    res.send indexHtml

  WebServer.post '/startshow', urlencodedParser, (req,res)->
    if lightshow? then clearInterval lightshow
    console.log "New show request: ", req.body
    switch req.body.show
      when "Rainbow Rows"
        lightshow = shows.rainbowShow req.body.colorArray, .4, 777
      when "Rave Lights"
        lightshow = shows.flashShow req.body.colorArray, .25, 77
      when "Waves"
        lightshow = shows.waveShow req.body.colorArray, 13, 13
      when "Chill"
        lightshow = shows.sinShow req.body.colorArray
      when "Cycle"
        lightshow = shows.waveShow req.body.colorArray, 13, 55
        setInterval ->
          clearInterval lightshow
          lightshow = shows.rainbowShow req.body.colorArray, .4, 777
          setTimeout ->
            clearInterval lightshow
            lightshow = shows.flashShow req.body.colorArray, .25, 77
            setTimeout ->
              clearInterval lightshow
              lightshow = shows.waveShow req.body.colorArray, 13, 13
            , 10000
          , 10000
        , 30000

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
      button class:'btn btn-primary btn-lg col-xs-6', "Rainbow Rows"
      button class:'btn btn-primary btn-lg col-xs-6', "Rave Lights"
      button class:'btn btn-primary btn-lg col-xs-6', "Waves"
      button class:'btn btn-primary btn-lg col-xs-6', "Chill"
      button class:'btn btn-primary btn-lg col-xs-12', "Cycle"
    script src:"bundle.js"

indexHtml = ck.render indexTemplate

WebServer.use(express.static 'public')
