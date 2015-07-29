$ = require "jquery"

module.exports = ->
  $('th').on 'click', (e)->
    cate = $(@).text()
    if !$(@).hasClass('selected')
      $(@).addClass('selected')
