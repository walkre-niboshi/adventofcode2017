
import sequtils, strutils, deques, tables, sets
type
    Coordinate = tuple[x,y: int]
type
    Direction = enum
        ne, n, nw, sw, s, se

proc toDirection(dir: string): Direction =
    case dir
    of "ne":
        return ne
    of "n":
        return n
    of "nw":
        return nw
    of "sw":
        return sw
    of "s":
        return s
    of "se":
        return se

proc moved(coordinate: Coordinate, dir: Direction): Coordinate =
    let
        x = coordinate.x
        y = coordinate.y
    case dir
    of ne:
        return (x+1, y+1)
    of n:
        return (x, y+2)
    of nw:
        return (x-1, y+1)
    of sw:
        return (x-1, y-1)
    of s:
        return (x, y-2)
    of se:
        return (x+1, y-1)

let input = readLine(stdin).split(",")

var
    dest: Coordinate = (0,0)
    allPosition = initSet[Coordinate]()
allPosition.incl((0,0))
for dir in input:
    dest = moved(dest, toDirection(dir))
    allPosition.incl(dest)

var
    deq = initDeque[Coordinate]()
    dist = initTable[Coordinate, int]()
deq.addLast((0,0))
dist.add((0,0), 0)
while true:
    let cur = deq.popFirst
    allPosition.excl(cur)
    if allPosition.len == 0:
        echo(dist[cur])
        break

    for dir in Direction:
        let nxt = moved(cur, dir)
        if dist.hasKey(nxt):
            continue
        deq.addLast(nxt)
        dist.add(nxt,  dist[cur]+1)
