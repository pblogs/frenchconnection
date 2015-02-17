module V1
  class Base < Grape::API
    version 'v1', using: :path, vendor: 'orwapp', cascade: false

    mount Users
    mount Tasks
    mount Projects
    mount Customers
    mount HoursSpents
    mount Inventories
    mount MobilePictures
    mount BlogArticles
    mount BlogProjects
    mount Certificates
    mount Skills
    mount Attachments

  end
end
