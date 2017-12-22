import strutils, strscans, tables, sequtils

type Coordinate = tuple[x, y, z: int]

proc `+=`(p: var Coordinate; q: Coordinate) =
    p.x += q.x
    p.y += q.y
    p.z += q.z

var
    point, velocity, acceleration = newSeq[Coordinate]()
while true:
    try:
        let input = stdin.readLine
        var
            p, v, a: Coordinate 
        discard scanf(input, "p=<$i,$i,$i>, v=<$i,$i,$i>, a=<$i,$i,$i>", p.x, p.y, p.z, v.x, v.y, v.z, a.x, a.y, a.z);
        point.add(p);
        velocity.add(v);
        acceleration.add(a);
    except IOError:
        break

var left = newSeqWith(point.len, true)
for i in 1..1000000:
    var used = initTable[Coordinate, int]()
    for j in 0..point.high:
        if not left[j]:
            continue
        velocity[j] += acceleration[j]
        point[j] += velocity[j]
        if used.hasKey(point[j]):
            left[used[point[j]]] = false
            left[j] = false
        else:
            used[point[j]] = j

echo(left.filter(proc(x: bool): bool = x).len)

