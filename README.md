# DCTRL Sidewalk

## TL;DR for people just trying to get the successfully installed sidewalk implementation at DCTRL Vancouver up and running again after the server goes down

* Open a terminal window
* cd sidewalk
* npm run compile
* Open the browser
* Navigate to localhost:3456
* Enjoy the delightfully straightforward UI, select cool patterns etc and even play competitive tetris on it

-----------------------------------------------------------------------------

This is a project to control the DCTRL LED sidewalk with a web interface. It should be possible to connect this code to any open-pixel-control hardware by modifying the layout file. 

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
               
`npm run compile`           # compile css/js bundles and start the server
               

## Create a Localshow:
If you want to run a sample LED display for testing you have to build the
executable file from openpixelcontrol source (which is included in this repo) with the following code:

:: you need these dependencies to run the build::        
`sudo apt-get install mesa-common-dev freeglut3-dev`        

:: move into the /sidewalk/openpixelcontrol/ folder and run make       
`cd openpixelcontrol`  
`make`

:: run the openpixel localshow using my npm script
`npm run localshow`
            
or run the executable directly and have the option to specify another layout file:          
`./sidewalk/bin/gl_server -l <path-to-layout-json-file>`      
         

You must make sure that the port the localshow is running on is
the same as the port being connected to in opc_controller/opc_init.coffee.

`npm run compile`           # compile css/js bundles and start the server

When successfully running you will be able to access a website on
localhost:3456 and actions there will be displayed on the localshow
display.
