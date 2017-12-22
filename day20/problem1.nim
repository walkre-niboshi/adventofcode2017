import strutils, basic3d, strscans

var
    point = newSeq[Point3d]()
    velocity, acceleration = newSeq[Vector3d]()
while true:
    try:
        let input = stdin.readLine
        var
            p: Point3d
            v, a: Vector3d
        discard scanf(input, "p=<$f,$f,$f>, v=<$f,$f,$f>, a=<$f,$f,$f>", p.x, p.y, p.z, v.x, v.y, v.z, a.x, a.y, a.z);
        point.add(p);
        velocity.add(v);
        acceleration.add(a);
    except IOError:
        break

for i in 1..1000000:
    for j in 0..point.high:
        velocity[j] += acceleration[j]
        point[j] += velocity[j]

var
    ans:int
    dist: float = -1 
for i in 0..point.high:
    let d = point[i].x.abs+point[i].y.abs+point[i].z.abs
    if dist == -1 or dist > d:
        ans = i
        dist = d

echo(ans)
