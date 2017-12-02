import strutils
import sequtils

proc evenlyDivision(a: seq[int]): int =
    for i in countup(0, len(a)-1):
        for j in countup(0, len(a)-1):
            if i == j:
                continue
            if a[i] mod a[j] == 0:
                result = a[i] div a[j]

var sum: int = 0
while true:
    var s: string
    try:
        s = readLine(stdin)
    except IOError:
        break

    sum += evenlyDivision(s.split().map(parseInt))

echo sum