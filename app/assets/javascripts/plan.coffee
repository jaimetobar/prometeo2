hiddenInput = (name,value)->
  $("<input>")
    .attr({
      "type":"hidden"
      "name":name
    })
    .val(value)

ready = ->

  $(document).on "click",".btn-select-accreditation", ->

    $form = $("form")
    $btn = $(@)
    id = $btn.data("accreditation-id")
    $input = $form.find("input[value='#{id}']")
    if !!$input.length
      $input.remove()
      $btn.removeClass "active"
    else
      $form.append( hiddenInput("accreditations[]",id) )
      $btn.addClass "active"

$(document).on("ready",ready)
