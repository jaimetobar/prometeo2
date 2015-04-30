
execDatetimePicker = ($el)->
  $el.datetimepicker(
    format: 'YYYY-MM-DD'
    showClear: true
    showClose: true
    widgetPositioning:
      horizontal: 'auto'
      vertical: 'bottom'
  )

ready = ->
  execDatetimePicker($('.datetimepicker'))


$(document).on "fields_added.nested_form_fields", (event,param) ->
  execDatetimePicker($(event.target).find('.datetimepicker'))


$(document).ready(ready)
$(document).on('page:load', ready)
