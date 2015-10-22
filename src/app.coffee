# Create angular app
app = angular.module 'trackaKeepa', ['ui.router', 'btford.socket-io']

# Make Modernizr injectable
app.constant 'Modernizr', Modernizr
