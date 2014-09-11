#require 'v1/entities/users'
module V1
  class Base < Grape::API
    version 'v1', using: :path, vendor: 'orwapp', cascade: false

    mount Users
    #mount V1::Entities::Users

  end
end
