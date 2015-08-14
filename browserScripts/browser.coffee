###
# On click it pushes the picker value onto
# the colors list,
# then it creates a span below with
# class colorPick. Css can add a size
# to make this visible. Color this
# span the color chosen, as well.
###
###
# There will be a button that clears the list of
# chosen colors. When you click it clear the colors
# array and empty the DOM.
###
###
# There will be a button that sends the collected
# info to the server. I convert the array to a document
# for no reason?
###

$ = require "jquery"
ColorPicker = require "color-picker"
picker = new ColorPicker()
menu = require "../templates/menuPublic/menu.coffee"
#ColorpickerHtml = require("../templates/colorpicker.coffee")

colors = []

$(document).ready ->
  menu()
  $.get '/getpicker', (res)->
    $(".Color_Picker").append (res)
    picker.el.appendTo '.picker'
    picker.size($('.menu').width()*.75)

  $(".menu").on "click", ".color-picker .main", (e)->
    e.preventDefault()
    col = picker.color()
    x = picker.color()
    x = x.substring(4,x.length-1)
      .replace(/ /g,"")
      .split(',')
    colors.push x
    $(".colors").append "<span class='colorPick'></span>"
    $("span:last").css "background", col

  $(".menu").on "click",".clearcolor" ,(e)->
    e.preventDefault()
    colors = []
    $(".colors").empty()

  $(".menu").on "click", ".send", (e)->
    e.preventDefault()
    selection = $(".selected").text()
    submitArray = $("form.#{selection}").serializeArray()
    submitDoc = {}
    for doc in submitArray
      submitDoc[doc['name']] = doc['value']
    i = 0
    submitDoc["colorArray"] = colors
    console.log submitDoc
    $.ajax
      type:'POST'
      url:'/create'
      data: submitDoc
      success: ->
        console.log "created"
