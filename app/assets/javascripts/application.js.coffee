#= require jquery
#= require jquery_ujs
#= require jquery.ui.all
#= require jquery.turbolinks
#= require turbolinks
#= require angular
#= require angular-route
#= require angular-resource

#= require_self
#= require_tree ./models
#= require_tree ./controllers
#= require ./angular-app/router

@App = angular.module("Orwapp", ["ngResource"])

#= require_tree .
