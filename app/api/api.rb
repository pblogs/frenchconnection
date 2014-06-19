class API < Grape::API
  prefix 'api'
  mount V1::Person
end
