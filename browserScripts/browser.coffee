$ = require "jquery"
ColorPicker = require "color-picker"
picker = new ColorPicker()
#bootstrap = require 'bootstrap'
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

  $(".tetrisButton").on "click" , (e)->
    e.preventDefault()
    if $(@).hasClass('tetrisButton')
      $(@).find('.tetrisControls').show()
      submitDoc = {}
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
    $(@).removeClass('tetrisButton')


  $(".tetrisControls").on "click", "div", (e)->
    e.preventDefault()
    direction = $(@).attr('class')
    $.ajax
      type:'GET'
      url:"tetris/#{direction}"
      success: ->
        null
