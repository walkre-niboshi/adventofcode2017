import strutils
import sequtils

var checkSum: int = 0
while true:
    var s: string
    try:
        s = readLine(stdin)
    except IOError:
        break

    let a = s.split().map(parseInt)
    var
        minValue: int = 1000000000
        maxValue: int = -1000000000
    
    for x in a:
        if minValue > x:
            minValue = x
        if maxValue < x:
            maxValue = x
    checkSum += maxValue - minValue

echo checkSum