import strutils, sequtils

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

var graph = newSeqWith(0, newSeq[Natural]())
while true:
    try:
        let input = readLine(stdin).split().map(proc (s: string):string =s.replace(","))
        graph.add(input[2..input.high].map(proc (s: string): Natural = Natural(parseInt(s))))
    except IOError:
        break

var uf = initUnionFind(graph.len)
for i in 0..graph.high:
    for j in graph[i]:
        uf.unite(i, j)

echo(uf.groupNum)