import strutils, sequtils, algorithm

type
    UnionFind* = object
        parent*, rank*, groupSize: seq[Natural]
        groupNum*: Natural

proc initUnionFind*(size: Natural): UnionFind =
    result.parent = newSeq[Natural](size)
    result.rank = newSeq[Natural](size)
    result.groupSize = newSeq[Natural](size).map(proc(x: Natural): Natural = 1)
    result.groupNum =size
    for i in 0..size-1:
        result.parent[i] = i
    
proc find*(uf: var UnionFind, x: Natural): Natural =
    if uf.parent[x] == x:
        return x
    uf.parent[x] = uf.find(uf.parent[x])
    return uf.parent[x]

proc unite*(uf: var UnionFind, x,y: Natural): void =
    let
        x2 = uf.find(x)
        y2 = uf.find(y)
    if x2 == y2:
        return
    if uf.rank[x2] < uf.rank[y2]:
        uf.parent[x2] = y2
        uf.groupSize[y2] += uf.groupSize[x2]
    else:
        uf.parent[y2] = x2
        uf.groupSize[x2] += uf.groupSize[y2]
        if uf.rank[x2] == uf.rank[y2]:
            inc(uf.rank[x2])
    dec(uf.groupNum)

proc groupSizeOf*(uf: var UnionFind, x: Natural): Natural =
    return uf.groupSize[uf.find(x)]

proc reversedCircularly(a: seq[int], first, last:int): seq[int] =
    if first <= last:
        return concat(a[0..first-1], reversed(a, first, last), a[last+1..a.high])
    result = concat(a[last+1..a.high], a[0..last])
    result = concat(result[0..first-last-2], reversed(result, first-last-1, a.high))
    result = concat(result[a.high-last..a.high], result[0..a.high-last-1])

proc round(list: var seq[int], currentPosition: var int, skipSize: var int, lengths: seq[int]) = 
    for length in lengths:
        if length > 0:
            list = reversedCircularly(list, currentPosition, (currentPosition + length - 1) mod list.len)
        currentPosition = (currentPosition + length + skipSize) mod list.len
        inc(skipSize)

proc knotHash(s: string): string =
    let lengths = concat(toSeq(s.items).map(proc (ch: char): int = ord(ch)), @[17, 31, 73, 47, 23])
    var
        list = newSeq[int](256)
        currentPostion, skipSize = 0
    for i in 0..255:
        list[i] = i

    for i in 0..63:
        round(list, currentPostion, skipSize, lengths)

    return list.distribute(16).map(proc (xs: seq[int]): int = foldl(xs, a xor b)).map(proc (x: int): string = toBin(x, 8)).foldl(a & b)

let prefix = readLine(stdin)
var grid = newSeq[string]()
for i in 0..127:
    grid.add((prefix & "-" & i.intToStr).knotHash)

var
    uf = initUnionFind(128*128)
    countFree = 0
for y in 0..127:
    for x in 0..127:
        if grid[y][x] == '0':
            inc(countFree)
            continue
        for d in @[(1, 0), (0, 1), (-1, 0), (0, -1)]:
            let
                ny = y+d[0]
                nx = x+d[1]
            
            if ny<0 or 127<ny or nx<0 or 127<nx or grid[ny][nx] == '0':
                continue
            uf.unite(y*128+x, ny*128+nx)
echo(uf.groupNum-countFree)