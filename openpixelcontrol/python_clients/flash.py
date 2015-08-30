import opc
import time
import random
client = opc.Client('localhost:22000')


def distort(c):
    mod = [0,0,0]
    d = random.random() - .5
    mod[0] = max(c[0] + 123*d,0)
    d = random.random() - .5
    mod[1] = max(c[1] + 123*d,0)
    d = random.random() - .5
    mod[2] = max(c[2] + 123*d,0)
    modtuple = (mod[0],mod[1],mod[2])
    return modtuple

def color(rgb):
    i = 0
    while i < (13*50):
       x.append (distort(rgb))
       i = i +1 

def colorSwitcher(colors,switch):
    color(colors[switch])

colors=[(240,50,50),(200,150,100),(200,33,102),(150,105,166)]
cap = len(colors)
switch = 0 
count = 0
while count<9999:
    x=[]
    count = count + 1
    switch = (switch + 1) % cap
    colorSwitcher(colors,switch)
    client.put_pixels(x, channel=0)
    time.sleep(.1)
