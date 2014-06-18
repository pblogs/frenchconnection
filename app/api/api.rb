class API < Grape::API
  prefix 'api'
  mount V1::Users
end
