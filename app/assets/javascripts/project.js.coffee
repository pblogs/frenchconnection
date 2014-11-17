add_attachment = ->
  $('.project-attachments').find('.field').first().clone()
    .find('input').val('').insertBefore($('.plus-button'))
$ ->
  $('.plus-button').on 'click', ->
    add_attachment()

