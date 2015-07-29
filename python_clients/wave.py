import opc
import time
import random
#client = opc.Client('192.168.1.99:7890')
client = opc.Client('localhost:7890')
colors=[(204,0,204)]
fps=1
fill=.25

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
    while i < (13*67):
       d = random.random()
       if d < fill:
           x.append (distort(rgb))
       else:
          x.append((0,0,0))
       i = i +1 

def colorwave(rgb,j):
    i = 0
    while i < (13*67):
       if j==0:
           x.append((255,0,0))
       else:
           d = random.random()
           if d < fill:
               x.append (distort(rgb))
           else:
               x.append((0,0,0))
       i = i +1 
       if i%13 == 0:
           j = j + 1
       if j > 5:
           j=1

def colorSwitcher(colors,switch,j):
    colorwave(colors[switch],j)

switch = 0 
count = 0

cap = len(colors)
j = 0
while True:
    j = j + 1
    x=[]
    count = count + 1
    switch = (switch + 1) % cap
    colorSwitcher(colors,switch, j%13)
    client.put_pixels(x, channel=0)
    time.sleep(1/fps)
