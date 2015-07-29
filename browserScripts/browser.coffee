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
menu = require "./menu.coffee"

###
#
# This code starts the color picker,
# attaches it to any picker class in the
# DOM:
###
colors = []
$(document).ready ->
  menu()
  picker.el.appendTo '.picker'

  $(".pickcolor").on "click", ->
    col = picker.color()
    x = picker.color()
    x = x.substring(4,x.length-1)
      .replace(/ /g,"")
      .split(',')
    colors.push x
    console.log colors
    $(".picker").append "<span class='colorPick'></span>"
    $("span:last").css "background", col
  $(".clearcolor").on "click", ->
    colors = []
    $(".colors").empty()
  $(".create").on "click", ->
    i = 0
    colordoc = {}
    console.log "sending colors: #{colors}"
    i = 0
    for x in colors
      colordoc[i]=x
      i++
    $.ajax
      type:'POST'
      url:'/create'
      data: colordoc
      success: ->
        console.log "created"
