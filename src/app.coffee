# Connect to proper firebase
if window.location.host.indexOf(':') > -1
  appUrl = 'https://tracka-keepa-dev.firebaseio.com'
else
  appUrl = window.location.host

# Create angular app
app = angular.module 'trackaKeepa', [
  'firebase'
  'ngMaterial'
  'ngAnimate'
]

# Make Modernizr injectable
app.constant 'Modernizr', Modernizr

# Configure ngMaterial
app.config [
  '$mdThemingProvider'
  ($mdThemingProvider) ->
    $mdThemingProvider.theme 'default'
]

# Create console.log for incompatible browsers
window.console = window.console or {}
window.console.log = window.console.log or ->

# Empty anchor links go nowhere
$ ->
  $("a[href='#']").click (e) ->
    e.preventDefault()