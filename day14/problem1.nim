import strutils, sequtils, algorithm

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
var usedNum = 0
for i in 0..127:
    usedNum += toSeq((prefix & "-" & i.intToStr).knotHash.items).filter(proc (c: char): bool = return c == '1').len
echo(usedNum)
