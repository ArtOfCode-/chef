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

  $('.category-select').select2({
    theme: 'bootstrap'
    ajax:
      url: "/categories/find"
      dataType: 'json'
      delay: 100
      data: (params) ->
        return {q: params.term, page: params.page}
      processResults: (data, params) ->
        results = []
        $.each(data.items, (index, item) ->
          results.push({id: item.id, text: item.name})
        )
        return {results: results, pagination: {more: data.has_more}}
      cache: true
  })

  $('.access-select').on('change', () ->
    $('.access-desc').text($(this).find('option:selected').data('description'))
  )

  $('.category-select').on('change', () ->
    $('.category-desc').text($(this).find('option:selected').data('description'))
  )

  $('.favorite-toggle').on('ajax:success', (ev, data, status, xhr) ->
    $('.favorite-icon').removeClass(data['remove_class']).addClass(data['add_class'])
    $('.favorite-count').text(data['favorite_count'])
  ).on('ajax:error', (ev, xhr, status, error) ->
    chef.createNotification('danger', "Can't toggle your favorite right now - try again later.", $(this))
  )

  if ($('.mde-enabled').length)
    $('.mde-field').each(() ->
      mde = new SimpleMDE({
        element: this,
        forceSync: true,
        indentWithTabs: false,
        tabSize: 4
      })
    )

  $('.new-comment-form').on('ajax:success', (ev, data, status, xhr) ->
    $('.comments').append(data['insert'])
  ).on('ajax:error', (ev, xhr, status, error) ->
    chef.createNotification('danger', "Can't create a comment right now - try again later.", $(this).children('input[type=submit]'))
  )

)
