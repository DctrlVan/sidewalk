spacing = 0.11

cols = [-6..6]  #13 cols
rows = [-31..31] #63 rows

lines = []
for c in cols
  for r in rows
    lines.push
      "point" : [c*spacing,0,r*spacing]

json = JSON.stringify lines

# From the command line, create a layout by
# use coffee <this file>  >  <destinationFile>.json
console.log json
