# Moves files from development to app. Sets up proper chrome extension
# compile coffee script/sass/slim :)
`coffee --compile dev/views/quicktaskk.coffee`
`coffee --compile dev/views/taskk.coffee`
`sass dev/views/taskk_style.sass app/css/taskk_style.css`
`slimrb dev/views/taskk.slim --pretty > app/taskk.html`

`cp -r dev/public/* app/`
`cp -r dev/views/*.js app/js/`