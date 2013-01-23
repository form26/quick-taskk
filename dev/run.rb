require 'sinatra'
require 'slim'
require 'coffee-script'
require 'sass'

get('/') { slim :taskk }

get('/js/quick_taskk.js') { coffee :quick_taskk}

get('/css/quick_taskk.css') { sass :quick_taskk}