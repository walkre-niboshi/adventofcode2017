import strutils, algorithm

var
    depths, ranges = newSeq[int]()
while true:
    try:
        let
            input = readLine(stdin)
            dep = input.replace(":").split()[0].parseInt
            ran = input.replace(":").split()[1].parseInt
        depths.add(dep)
        ranges.add(ran)
    except IOError:
        break

for delay in 0..int.high:
    var isAns = true
    for i in 0..depths.high:
        let
            dep = depths[i] + delay
            ran = ranges[i]
        if min(dep mod (ran*2-2), ran*2-2-(dep mod (ran*2-2))) == 0:
            isAns = false
            break
    if isAns:
        echo(delay)
        break