class DynamicForm
  include Mongoid::Document
  field :field_name,        type: String # E.g Customer name
  field :populate_at,       type: Symbol # automatically, web, app_start, app_stop
  field :same_as,           type: Symbol # customer_name, customer_address, project_address
  field :autocomplete_from, type: Symbol # customer_name, customer_address, project_address
  field :title,             type: String # Varmepumpeskjema

  accepts_nested_attributes_for :rows
end
