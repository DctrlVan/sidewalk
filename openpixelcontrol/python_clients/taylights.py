import opc
import time



client = opc.Client('localhost:22000')
def color(rgb):
    i = 0
    while i < (13*33):
       x.append (rgb)
       i = i +1 
x = []
def colorSwitcher(colors,switch):
    color(colors[switch])
colors = [(240,10,10),(10,240,10),(10,10,240),(44,55,66)]
cap = len(colors)
switch = 0 
while True:
    x=[]
    switch = (switch + 1) % cap
    colorSwitcher(colors,switch)
    client.put_pixels(x, channel=0)
    time.sleep(1)
