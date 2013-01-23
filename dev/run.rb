require 'sinatra'
require 'slim'
require 'coffee-script'
require 'sass'

get('/') { slim :taskk }

get('/js/quick_taskk.js') { coffee :quick_taskk}

get('/css/taskk_style.css') { sass :taskk_style}