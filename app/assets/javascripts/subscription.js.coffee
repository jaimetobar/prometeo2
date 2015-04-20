doc = $(document)
doc.on 'ready page:load', ->
  doc.on 'click', '[type=checkbox]', ->
    # Get the task ID
    $el = $(this).siblings()
    if $el.val() == 'true'
      $el.val 'false'
    else
      $el.val 'true'
    return
  return
  