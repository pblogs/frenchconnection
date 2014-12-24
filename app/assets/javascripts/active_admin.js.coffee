#= require active_admin/base
#= require tinymce
get_image_owner = ->
  JSON.stringify({ id: $('#content_id').val(), type: $('#content_type').val() })

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

$(document).ready ->
  if not $("#content_id").val() or not $("#content_type").val()
    load_tinymce("image link")
  else
    load_tinymce("image link uploadimage")
  return
