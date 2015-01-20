ActiveAdmin.register BlogVideo do

  permit_params :title, :content, :video_url, :published, :publish_date

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :title
      f.input :content, input_html: { class: :tinymce }
      f.input :video_url
      f.input :published
      f.input :publish_date, as: :datepicker
    end
    f.actions
  end
end
