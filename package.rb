# Moves files from development to app. Sets up proper chrome extension

# compile coffee script/sass/slim :)
`coffee /views/quick_taskk.coffee --compile`
`sass dev/views/quick_taskk.sass app/css/quick_taskk.css`
'slimrb dev/views/taskk.slim --pretty > app/taskk.html
