hiddenInput = (name,value)->
  $("<input>")
    .attr({
      "type":"hidden"
      "name":name
    })
    .val(value)

ready = ->
  $btnRole = $(".btn-role")
  $btnRole.on("click", ->
    $btnRole.removeClass("active")
    $(@).addClass("active")
  )
  $(document).on("click",".course", ->
    $course = $(@)
    if $course.hasClass("active")
      $course.removeClass("active")
      $course.find("input").remove()
    else
      courseId = $course.data("course")
      $course.addClass("active")
      $course.append(hiddenInput("plan[courses][]",courseId))
  )


$(document).on("ready page:load",ready)
