
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

    let offset = instruction[x]
    if instruction[x]>=3:
        dec(instruction[x])
    else:
        inc(instruction[x])
    x += offset

echo(ans)