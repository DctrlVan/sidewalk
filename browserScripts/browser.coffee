$ = require "jquery"
ColorPicker = require "color-picker"
picker = new ColorPicker()
#ColorpickerHtml = require("../templates/colorpicker.coffee")

colors = []
$(document).ready ->
  picker.el.appendTo '.picker'
  picker.size($('.Color_Picker').width()*.59)

  $(".Color_Picker").on "click", ".color-picker .main", (e)->
    e.preventDefault()
    col = picker.color()
    x = picker.color()
    x = x.substring(4,x.length-1)
      .replace(/ /g,"")
      .split(',')
    colors.push x
    $(".colors").append "<span class='colorPick'></span>"
    $("span:last").css "background", col

  $(".Color_Picker").on "click",".clearcolor" ,(e)->
    e.preventDefault()
    colors = []
    $(".colors").empty()

  $(".submitButtons").on "click", "button", (e)->
    e.preventDefault()
    submitDoc = {}
    console.log $(@).text()
    console.log colors
    submitDoc["show"] = $(@).text()
    submitDoc["colorArray"] = colors
    $.ajax
      type:'POST'
      url:'/startshow'
      data: submitDoc
      success: ->
        $(@).text("~~~!!!active!!!~~~")
        setTimeout ->
          $(@).text(submitDoc["show"])
        , 2000

  $(".tetrisButtons").on "click", "button", (e)->
    e.preventDefault()
    $.ajax
      type:'GET'
      url:"tetris/#{$(@).text()}"
      success: ->
        null
