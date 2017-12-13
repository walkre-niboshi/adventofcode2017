import strutils
import sequtils
import algorithm

proc reversedCircularly(a: seq[int], first, last:int): seq[int] =
    if first <= last:
        return concat(a[0..first-1], reversed(a, first, last), a[last+1..a.high])
    result = concat(a[last+1..a.high], a[0..last])
    result = concat(result[0..first-last-2], reversed(result, first-last-1, a.high))
    result = concat(result[a.high-last..a.high], result[0..a.high-last-1])

let lengths = readLine(stdin).split(',').map(parseInt)
var
    list = newSeq[int]()
    currentPosition, skipSize = 0

for i in 0..255:
    list.add(i)

for length in lengths:
    if length > list.len:
        continue
    if length > 0:
        list = reversedCircularly(list, currentPosition, (currentPosition + length - 1) mod list.len)
    currentPosition = (currentPosition + length + skipSize) mod list.len
    inc(skipSize)

echo(list[0]*list[1])
