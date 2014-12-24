ActiveAdmin.register BlogProject do

  permit_params :title, :content, :image, :published, :publish_date

  form html: { enctype: 'multipart/form-data' } do |f|
    f.semantic_errors
    f.inputs do
      f.input :id, as: :hidden, input_html: { id: :content_id }
      f.input :type, as: :hidden, input_html: { id: :content_type,
                                                value: f.object.class.name }
      f.input :title
      f.input :content, input_html: { class: :tinymce },
              hint: I18n.t('blog.save_project_for_image_upload')
      f.input :image, as: :file,
              hint: f.image_tag(f.object.image.url)
      f.input :published
      f.input :publish_date, as: :datepicker
    end
    f.actions
  end
end
