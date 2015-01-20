#= require active_admin/base
#= require tinymce
$(document).ready ->
  tinyMCE.init
    mode: "textareas"
    theme: "modern"
    toolbar: "undo redo | styleselect | bold italic
      | alignleft aligncenter alignright alignjustify
      | bullist numlist outdent indent | table | fontsizeselect | uploadimage"
    editor_selector: "tinymce"
    plugins: "image link uploadimage"
    menubar: false
  return
