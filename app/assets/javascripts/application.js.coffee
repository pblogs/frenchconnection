#= require jquery
#= require jquery_ujs
#= require jquery.ui.all
#= require jquery.turbolinks
#= require turbolinks
#= require angular
#= require angular-route
#= require angular-resource

#= require_self
#= require_tree ./angular-app/models
#= require_tree ./angular-app/controllers
#= require ./angular-app/router

@App = angular.module("Orwapp", ["ngResource"])

#= require_tree .
