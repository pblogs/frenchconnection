ActiveAdmin.register BlogProject do

  permit_params :title, :content, :image, :published, :publish_date,
                blog_images_attributes: [:id, :image, :_destroy, :owner]

  form html: { enctype: 'multipart/form-data' } do |f|
    f.semantic_errors
    f.inputs do
      f.input :id, as: :hidden, input_html: { id: :content_id }
      f.input :type, as: :hidden, input_html: { id: :content_type,
                                                value: f.object.class.name }
      f.input :title
      f.input :content, input_html: { class: :tinymce },
              hint: I18n.t('blog.save_project_for_image_upload')
      f.has_many :blog_images, allow_destroy: true do |ff|
        ff.input :image, as: :file,
                 hint: f.image_tag(ff.object.image.url(:small))
      end
      f.input :published
      f.input :publish_date, as: :datepicker
    end
    f.actions
  end
end
