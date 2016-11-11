class Api::ProductResource < JSONAPI::Resource
  model_name 'Product'
  attributes :title, :description, :permalink, :pictures, :meli_id
end
