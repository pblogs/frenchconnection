#= require active_admin/base
#= require tinymce
get_image_owner = ->
  JSON.stringify({ id: $('#content_id').val(), type: $('#content_type').val() })

$(document).ready ->
  tinyMCE.init
    mode: "textareas"
    theme: "modern"
    toolbar: "undo redo | styleselect | bold italic
      | alignleft aligncenter alignright alignjustify
      | bullist numlist outdent indent | table | fontsizeselect | uploadimage"
    editor_selector: "tinymce"
    plugins: "image link uploadimage"
    uploadimage_form_url: "/blog_images"
    uploadimage_hint: get_image_owner()
    menubar: false
  return
