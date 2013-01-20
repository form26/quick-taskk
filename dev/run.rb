require 'sinatra'
require 'slim'
require 'coffee-script'
require 'sass'

get('/') { slim :taskk }

get('/quick_taskk.js') { coffee :quick_taskk}

get('/quick_taskk.css') { sass :quick_taskk}