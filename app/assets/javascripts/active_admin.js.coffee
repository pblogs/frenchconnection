#= require active_admin/base
#= require tinymce
$(document).ready ->
  tinyMCE.init
    mode: "textareas"
    theme: "modern"
    editor_selector: "tinymce"
    toolbar: "styleselect | bold italic | undo redo | image | link"
    plugins: "image link"
    menubar: false
  return
