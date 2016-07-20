# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on('ready turbolinks:load', () ->

  $('.new-recipe-form, .edit-recipe-form').on('submit', (ev) ->
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

  $('.access-select').on('change', () ->
    $('.access-desc').text($(this).find('option:selected').data('description'))
  )

  $('.favorite-toggle').on('ajax:success', (ev, data, status, xhr) ->
    $('.favorite-icon').removeClass(data['remove_class']).addClass(data['add_class'])
    $('.favorite-count').text(data['favorite_count'])
  ).on('ajax:error', (ev, xhr, status, error) ->
    chef.createNotification('danger', "Can't toggle your favorite right now - try again later.", $(this))
  )

  if ($('.mde-field').length)
    editor = new SimpleMDE({
      element: $('.mde-field'),
      forceSync: true,
      indentWithTabs: false,
      tabSize: 4
    })

)
