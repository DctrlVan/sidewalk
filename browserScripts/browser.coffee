$ = require "jquery"

colors = []
$(document).ready ->

  $(".submitButtons").on "click", "button", (e)->
    e.preventDefault()
    submitDoc = {}
    submitDoc["show"] = $(@).text()
    submitDoc["colorArray"] = colors
    submitDoc["banner"] = $('.banner').val()
    submitDoc["imgShow"] = $('.imgShow').val()
    console.log submitDoc
    $.ajax
      type:'POST'
      url:'/startshow'
      data: submitDoc
      success: ->
        null

  $(".tetrisButton").on "click" , (e)->
    e.preventDefault()
    if $(@).hasClass('tetrisButton')
      $(".tetrisControls").show()
      $('html, body').animate({scrollTop:$(document).height()}, 'fast')
      submitDoc = {}
      submitDoc["show"] = $(@).text()
      submitDoc["colorArray"] = colors
      $.ajax
        type:'POST'
        url:'/startshow'
        data: submitDoc
        success: ->
          null

  $(".tetrisControls").on "click", "div", (e)->
    e.preventDefault()
    direction = $(@).attr('class')
    player = $(@).parent().attr('class').split(" ")[2]
    $.ajax
      type:'GET'
      url:"tetris/#{player}/#{direction}"
      success: ->
        null
