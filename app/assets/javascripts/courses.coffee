# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:load ready', ->
  $sessions = $(".sessions")
  $(".course_session_type input").on "click", ->
    $input = $(@)
    if $input.val() == "per_session"
      $sessions.show()
    else
      $sessions.hide()
