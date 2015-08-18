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
the module files are mis-labelled. You have to edit the file 
names. i.e. 'emitter-component' changes to emitter, jquery can
be removed completely from this submodule, use these commands:         
`mv node_modules/color-picker/node_modules/emitter-component/ node_modules/color-picker/node_modules/emitter`      
`sudo rm -rf node_modules/color-picker/node_modules/jquery-component`      
--- !!!!!!!!!!!!!!!!! ---------
Then:                 
`mkdir public && touch public/bundle.js`            
`npm run compile`        

Open a browser to localhost:3456

## local lightshow: 
you can launch a local light processor simulation using 
`./bin/gl_server -l sidewalk_layout.json
opc data can now be directed to localhost:22000














