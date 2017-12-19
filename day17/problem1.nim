import strutils

let steps = stdin.readLine.parseInt
var
    buffer = newSeq[int](1)
    currentPosition = 0
for i in 1..2017:
    currentPosition = (currentPosition + steps) mod buffer.len
    buffer.insert(i, currentPosition+1)
    inc(currentPosition)
echo(buffer[(currentPosition+1) mod buffer.len])