# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on('ready turbolinks:load', () ->

  $('.new-recipe-form').on('submit', (ev) ->
    unless $(this).data('calculated')
      ev.preventDefault()
      hours = $('.hours-input').val()
      mins = $('.minutes-input').val()
      seconds = (hours * 3600) + (mins * 60)
      $('.calc-time').val(seconds)
      $(this).data('calculated', true)
      $(this).submit()
    else
      return true
  )

)
