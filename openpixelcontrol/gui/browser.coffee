$ = require "jquery"
ColorPicker = require "color-picker"
picker = new ColorPicker()

colors = []

$(document).ready ->

  picker.el.appendTo '.picker'

  $(".colorpick").on "click", ->
    col = picker.color()
    x = picker.color()
    x = x.substring(4,x.length-1)
      .replace(/ /g,"")
      .split(',')
    colors.push x
    console.log colors
    $(".colors").append "<span></span>"
    $("span:last").css "background", col
  $(".colorclear").on "click", ->
    colors = []
    $(".colors").empty()

  $(".create").on "click", ->
    i = 0
    colordoc = {}
    for color in colors
      colordoc[i] = color
      i++
    console.log colordoc
    $.ajax
      type:'POST'
      url:'/create'
      data:colordoc
      success: ->
        console.log "created"
