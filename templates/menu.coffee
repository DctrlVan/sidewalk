ck = require 'coffeekup'
fs = require 'fs'

menu = ->
  div class:'menu', ->
    div ->
      h2 ->
        text TITLE
    table class:"categories table table-bordered", ->
        for title, fd of MENUDOC
          th title
    div ->
      for title, formDoc of MENUDOC
        form ".col-xs-12.#{TITLE}",->
          for field, data of formDoc
            label field
            switch data
              when 'text'       then input type:'text',name:field, class:'col-xs-12'
              when '$'          then input type:'number',step:"0.01",name:field, class:'col-xs-12'
              when 'int'        then input type:'number',step:1,name:field, class:'col-xs-12'
              when 'textbox'    then textarea cols:40, rows:5, name:field, class:'col-xs-12'
              when 'date'       then input type:'date', name:field, class:'col-xs-12'
              when 'float'      then input type:'number',name:field, class:'col-xs-12'
              when 'boolean'    then input type:'checkbox',name:field, class:'col-xs-12'
              when 'custom'     then div class:"#{field} col-xs-12"
              when 'range'      then input type:'range',name:field, class:'col-xs-12'
              when 'list'       then select class:"#{field} col-xs-12", ->
                option ' '
          button type:'submit', class:'col-xs-12', "CREATE"

module.exports = (TITLE,MENUDOC)->
  ck.render menu, locals:{MENUDOC, TITLE}
