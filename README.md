# openpixelgui

This is a project to create led lightshows for an open pixel control LED setup
and a web gui to activate, and modify those lightshows.

The projects main file is index.coffee, `coffee index.coffee` to host a local webserver
that hosts web content on 3456.

The LED connection controller is /opc_controller/shows.coffee, this has functions
that send opc data out using the npm opc module.

## Installing:

It is best if following packages are installed globally
`sudo npm install -g coffee-script gulp browserify`

`git clone https://github.com/DecentralVan/openpixelgui.git && cd openpixelgui`
`sudo npm install`


--- !!! There is a bug in the color-picker module !!! ---
For some reason in /node_modules/color-picker/node_modules/*  
the module file names are incorrect. You have to edit the file
names. i.e. 'emitter-component' changes to emitter. Use these commands:

`mv node_modules/color-picker/node_modules/emitter-component/ node_modules/color-picker/node_modules/emitter`

`sudo rm -rf node_modules/color-picker/node_modules/jquery-component`
--- !!!!!!!!!!!!!!!!! ---------
Then:

## Building a local open pixel display:
If you want to run a sample LED display for testing you have to build the
executable file from source with the following code:

`apt-get install mesa-common-dev freeglut3-dev`
`cd openpixelcontrol`
`make`
`cd ..`
`npm run localshow`
or `./openpixelcontrol/bin/gl_server -l <path-to-layout-json-file>`

You must make sure that the port the localshow is running on is
the same as the port being connected to in opc_controller/opc_init.coffee.

`npm run compile `           # compile css/js bundles and start the server

When successfully running you will be able to access a website on
localhost:3456 and actions there will be displayed on the localshow
display.
