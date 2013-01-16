require 'sinatra'
require 'slim'
require 'coffee-script'

get('/') { slim :taskk }

get('/quick_taskk.js') { coffee :quick_taskk}