# Moves files from development to app. Sets up proper chrome extension
`cp -r dev/public/* app/`

# compile coffee script/sass/slim :)
`coffee --compile --output dev/views/quick_taskk.coffee app/js/`
`sass dev/views/taskk_style.sass app/css/taskk_style.css`
`slimrb dev/views/taskk.slim --pretty > app/taskk.html`
