# Decentral Sidewalk

This is a project to control the Decentral LED sidewalk with a web interface. It should be possible to connect this code to any open-pixel-control hardware by modifying the layout file. 

The projects main file is index.coffee, running this file with coffee will create a web server at localhost:3456            
`coffee index.coffee` 

The LED controllers are in the /opc_controller/ directory. These files send out opc data. Edit the opc_init file to change where the opc data is being sent. Note that if a successful opc connection is not established you will get an error. To run locally the opc local lightshow must be open and listening on the correct port - see 'Create a Localshow' instructions below.

## Installing:

The following packages must be installed globally: coffee-script gulp browserify ::    

`sudo npm install -g coffee-script gulp browserify`

Clone the repository         :

`git clone <this repo>`         
`cd sidewalk`
`sudo npm install`

!!! --- BUG WARNING --- !!! There is a bug in the color-picker module !!! ---
For some reason in /node_modules/color-picker/node_modules/*  
the module file names are incorrect. You have to edit the file
names. i.e. 'emitter-component' changes to emitter. Use these commands:

`mv node_modules/color-picker/node_modules/emitter-component/ node_modules/color-picker/node_modules/emitter`

`sudo rm -rf node_modules/color-picker/node_modules/jquery-component`
--- !!!!!!!!!!!!!!!!! ---------


## Create a Localshow:
If you want to run a sample LED display for testing you have to build the
executable file from openpixelcontrol source (which is included in this repo) with the following code:

`sudo apt-get install mesa-common-dev freeglut3-dev`
`cd openpixelcontrol`  :: move into the /sidewalk/openpixelcontrol/ folder  
`make`
`npm run localshow`

or to specify another layout file:  `./sidewalk/bin/gl_server -l <path-to-layout-json-file>`

You must make sure that the port the localshow is running on is
the same as the port being connected to in opc_controller/opc_init.coffee.

`npm run compile`           # compile css/js bundles and start the server

When successfully running you will be able to access a website on
localhost:3456 and actions there will be displayed on the localshow
display.
