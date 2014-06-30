angular
  .module("app")
  .factory "Customer", ($resource) ->

    $resource("/api/v1/customers/:id.json", {}, {
      query: { method: "GET", isArray: true }
    })
