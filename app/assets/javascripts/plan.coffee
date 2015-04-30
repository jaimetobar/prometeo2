hiddenInput = (name,value)->
  $("<input>")
    .attr({
      "type":"hidden"
      "name":name
    })
    .val(value)

ready = ->


$(document).on("ready page:load",ready)
