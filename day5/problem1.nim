import strutils

var instruction = newSeq[int]()
while true:
    try:
        let input = readLine(stdin)
        instruction.add(input.parseInt)
    except EOFError:
        break

var x,ans = 0
while 0<=x and x<len(instruction):
    inc(ans)
    inc(instruction[x])
    x += instruction[x]-1

echo(ans)