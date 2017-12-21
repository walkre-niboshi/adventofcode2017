import strutils, sequtils

var diagram = newSeq[string]()
while true:
    try:
        diagram.add(stdin.readLine)
    except IOError:
        break

var
    y = 0
    x = diagram[0].find('|')
    dir = 3
    steps = 0
let
    dy = [0, -1, 0, 1]
    dx = [1, 0, -1, 0]
while true:
    let
        py = y
        px = x
    y = y+dy[dir]
    x = x+dx[dir]
    inc(steps) 

    if y < 0 or diagram.len <= y or x < 0 or diagram[0].len <= x or diagram[y][x] == ' ':
        break

    if diagram[y][x] == '+':
        for i in 0..3:
            let
                ny = y+dy[i]
                nx = x+dx[i]
            
            if ny == py and nx == px:
                continue
            if ny < 0 or diagram.len <= ny or nx < 0 or diagram[0].len <= nx:
                continue
            if diagram[ny][nx] == ' ':
                continue
            
            dir = i
            break

echo(steps)
