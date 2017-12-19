import strutils, collections.heapqueue

let steps = stdin.readLine.parseInt
var
    bufferLength = 1
    currentPosition, ans = 0
for i in 1..50000000:
    currentPosition = (currentPosition + steps) mod bufferLength
    if currentPosition == 0:
        ans = i
    inc(currentPosition)
    inc(bufferLength)
echo(ans)