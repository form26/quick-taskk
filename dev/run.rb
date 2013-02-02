require 'compass'
require 'sinatra'
require 'slim'
require 'coffee-script'
require 'sass'

# set sinatra's variables
set :app_file, __FILE__
set :root, File.dirname(__FILE__)
set :views, "views"

# configure do
#   Compass.add_project_configuration(File.join(Sinatra::Application.root, 'config', 'compass.config'))
# end

# at a minimum, the main sass file must reside within the ./views directory. here, we create a ./views/stylesheets directory where all of the sass files can safely reside.
get '/css/:name.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass(:"#{params[:name]}", Compass.sass_engine_options )
end

get('/') { slim :taskk }

get('/js/quick_taskk.js') { coffee :quick_taskk}