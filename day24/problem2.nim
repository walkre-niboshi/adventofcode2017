import strutils, sequtils, sets, deques

var
    graph = newSeqWith(100, newSeq[tuple[to, id: int]]())
    edges = newSeq[tuple[a, b: int]]()
while true:
    try:
        let
            input = stdin.readLine
            a = input.split("/")[0].parseInt
            b = input.split("/")[1].parseInt
        graph[a].add((b, edges.len))
        graph[b].add((a, edges.len))
        edges.add((a, b))
    except IOError:
        break

var
    que = initDeque[tuple[current: int, visited: int64]]()
    done = initSet[tuple[current: int, visited: int64]]()
    longest, strength = 0
que.addLast((0, 0'i64))
done.incl((0, 0'i64))
while que.len > 0:
    let tmp = que.popFirst
    var pushed = false
    for edge in graph[tmp.current]:
        if (tmp.visited and (1'i64 shl edge.id)) != 0:
            continue
        let next = (edge.to, tmp.visited or (1'i64 shl edge.id))
        if done.contains(next):
            continue
        done.incl(next)
        que.addLast(next)
        pushed = true
    
    if not pushed:
        let length = tmp.visited.toBin(64).count('1')
        if longest > length:
            continue

        var sum = 0
        for i in 0..edges.high:
            if (tmp.visited and (1'i64 shl i)) == 0:
                continue
            sum += edges[i].a + edges[i].b
        
        if longest < length:
            longest = length
            strength = sum
            continue
        
        strength = max(strength, sum)

echo(strength)