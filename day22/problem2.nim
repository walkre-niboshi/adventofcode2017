import strutils, sequtils, tables

var initialGrid = newSeq[string]()
while true:
    try:
        let input = stdin.readLine
        initialGrid.add(input)
    except IOError:
        break

var grid = initTable[tuple[y, x: int], int]()
for i in 0..initialGrid.high:
    for j in 0..initialGrid[i].high:
        grid[(i, j)] = if initialGrid[i][j] == '#': 2 else: 0 

let
    dy = [-1, 0, 1, 0]
    dx = [0, -1, 0, 1]
var
    y,x = initialGrid.len div 2
    dir, ans = 0

for i in 1..10000000:
    case grid[(y, x)]:
    of 0:
        dir = (dir+1) mod 4
    of 2:
        dir = (dir+3) mod 4
    of 3:
        dir = (dir+2) mod 4
    else:
        discard    
    
    grid[(y, x)] = (grid[(y, x)]+1) mod 4 
    
    if grid[(y, x)] == 2:
        inc(ans)

    y += dy[dir]
    x += dx[dir]
    if not grid.hasKey((y, x)):
        grid[(y, x)] = 0 

echo(ans)
