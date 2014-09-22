class API < Grape::API
  prefix 'api'

  format :json
  default_format :json

  mount ::V1::Base
end
