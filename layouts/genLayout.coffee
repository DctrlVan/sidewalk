spacing = 0.08

cols = [-6..6]  #13 cols
rows = [-30..31] #62 rows

lines = []
for c in cols
  for r in rows
    lines.push
      "point" : [c*spacing,0,r*spacing]

json = JSON.stringify lines

# From the command line, create a layout by
# use coffee <this file>  >  <destinationJsonFile>
console.log json
