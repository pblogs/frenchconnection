#= require active_admin/base
#= require tinymce
get_image_owner = ->
  JSON.stringify({ id: $('#content_id').val(), type: $('#content_type').val() })

ensure_one_main_image = ->
  $('.main_image_checkbox').on 'change', ->
    $('.main_image_checkbox').not(this).prop("checked", false)

load_tinymce = (plugins) ->
  tinyMCE.init
    mode: "textareas"
    theme: "modern"
    toolbar: "undo redo | styleselect | bold italic
          | alignleft aligncenter alignright alignjustify
          | bullist numlist outdent indent | table | fontsizeselect
          | uploadimage"
    editor_selector: "tinymce"
    plugins: plugins
    uploadimage_form_url: "/blog_images"
    uploadimage_hint: get_image_owner()
    menubar: false

$ ->
  ensure_one_main_image()

  $('.has_many_container.blog_images').on 'DOMNodeInserted', ->
    ensure_one_main_image()

  if not $("#content_id").val() or not $("#content_type").val()
    load_tinymce("image link")
  else
    load_tinymce("image link uploadimage")
  return
