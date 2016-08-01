# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('document').on('ready turbolinks:load', () ->

  $('.comment').on('ajax:success', (ev, data, status, xhr) ->
    $(this).fadeOut(200, () ->
      $(this).remove()
    )
  ).on('ajax:error', (ev, xhr, status, error) ->
    chef.createNotification('danger', "Can't delete comment right now - try again later.", $(this))
  )

)
