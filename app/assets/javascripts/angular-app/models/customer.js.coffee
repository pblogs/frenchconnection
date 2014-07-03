angular
  .module("app")
  .factory "Customer", ($resource) ->

    $resource("/api/v1/customers/:id.json", {}, {
      query: { method: "GET", isArray: true },
    })

    $resource("/api/v1/customers/:id.json", { id: "@id" }, {
      update: { method: "PUT" }
    })

# PUT    /api/v1/customers/:id(.:format)          
# api/v1/customers#update {:format=>:json}
