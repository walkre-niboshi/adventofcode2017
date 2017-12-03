import strutils
import tables

let p = readLine(stdin).parseInt

const
    dx = [1, 0, -1, 0]
    dy = [0, 1, 0, -1]
var
    currentX = 1
    currentY = 0
    dir = 0
    storedVal = initTable[tuple[x: int, y: int], int]()
storedVal[(x: 0, y: 0)] = 1

var i = 1
while true:
    var sumOfAdjacent: int = 0
    for x in countup(currentX-1, currentX+1):
        for y in countup(currentY-1, currentY+1):
            if not storedVal.contains((x: x, y: y)):
                continue
            sumOfAdjacent += storedVal[(x: x, y: y)]
    
    storedVal[(x: currentX, y:currentY)] = sumOfAdjacent

    if storedVal[(x: currentX, y: currentY)] > p:
        echo storedVal[(x: currentX, y: currentY)]
        break

    if not storedVal.contains((x: currentX+dx[(dir+1) mod 4], y:currentY+dy[(dir+1) mod 4])):
        currentX = currentX+dx[(dir+1) mod 4]
        currentY = currentY+dy[(dir+1) mod 4]
        dir = (dir+1) mod 4
    else:
        currentX += dx[dir]
        currentY += dy[dir]