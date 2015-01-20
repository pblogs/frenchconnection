ActiveAdmin.register BlogArticle do

  permit_params :title, :content, :image, :published, :publish_date

  form html: { enctype: 'multipart/form-data' } do |f|
    f.semantic_errors
    f.inputs do
      f.input :title
      f.input :content, input_html: { class: :tinymce }
      f.input :image, as: :file,
              hint: f.image_tag(f.object.image.url)
      f.input :published
      f.input :publish_date, as: :datepicker
    end
    f.actions
  end
end
