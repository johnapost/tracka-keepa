var app;

app = angular.module('trackaKeepa', ['firebase']);

app.constant('Modernizr', Modernizr);

window.console = window.console || {};

window.console.log = window.console.log || function() {};

$(function() {
  return $("a[href='#']").click(function(e) {
    return e.preventDefault();
  });
});