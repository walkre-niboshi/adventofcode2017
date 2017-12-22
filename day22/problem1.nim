import strutils, sequtils, tables

var initialState = newSeq[string]()
while true:
    try:
        let input = stdin.readLine
        initialState.add(input)
    except IOError:
        break

var grid = initTable[tuple[y, x: int], bool]()
for i in 0..initialState.high:
    for j in 0..initialState[i].high:
        grid[(i, j)] = if initialState[i][j] == '#': true else: false

let
    dy = [-1, 0, 1, 0]
    dx = [0, -1, 0, 1]
var
    y,x = initialState.len div 2
    dir, ans = 0

for i in 1..10000:
    if grid[(y, x)]:
        dir = (dir+3) mod 4
    else:
        dir = (dir+1) mod 4
    
    grid[(y, x)] = not grid[(y, x)]
    
    if grid[(y, x)]:
        inc(ans)

    y += dy[dir]
    x += dx[dir]
    if not grid.hasKey((y, x)):
        grid[(y, x)] = false

echo(ans)
