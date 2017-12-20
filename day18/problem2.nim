import strutils, sequtils, tables, deques

var
    instructions = newSeq[string]()
    xs = newSeq[string]()
    ys = newSeq[string]()

while true:
    try:
        let input = stdin.readLine.split
        instructions.add(input[0])
        xs.add(input[1])
        if input.len < 3:
            ys.add("")
        else:
            ys.add(input[2])
    except IOError:
        break

var
    eip = @[0, 0]
    registers = @[initTable[string, int](), initTable[string, int]()]
    queue = @[initDeque[int](), initDeque[int]()]
    wait = @[false, false]
    ans = 0
registers[0]["p"] = 0
registers[1]["p"] = 1

while true:
    if ((wait[0] and queue[0].len == 0) or eip[0] == instructions.len) and ((wait[1] and queue[1].len == 0) or eip[1] == instructions.len):
        break
    for i in @[1, 0]:
        if wait[i]:
            if queue[i].len > 0:
                wait[i] = false
                registers[i][xs[eip[i]]] = queue[i].popFirst
                inc(eip[i])
            else:
                continue
        while eip[i] < instructions.len:
            case instructions[eip[i]]:
            of "snd":
                queue[1-i].addLast(if xs[eip[i]].isAlphaAscii: (if registers[i].contains(xs[eip[i]]): registers[i][xs[eip[i]]] else: 0) else: xs[eip[i]].parseInt)
                if i == 1:
                    inc(ans)
            of "set":
                registers[i][xs[eip[i]]] = if ys[eip[i]].isAlphaAscii: (if registers[i].contains(ys[eip[i]]): registers[i][ys[eip[i]]] else: 0) else: ys[eip[i]].parseInt
            of "add":
                if not registers[i].contains(xs[eip[i]]):
                    registers[i][xs[eip[i]]] = 0
                registers[i][xs[eip[i]]] += (if ys[eip[i]].isAlphaAscii: (if registers[i].contains(ys[eip[i]]): registers[i][ys[eip[i]]] else: 0) else: ys[eip[i]].parseInt)
            of "mul":
                if not registers[i].contains(xs[eip[i]]):
                    registers[i][xs[eip[i]]] = 0
                registers[i][xs[eip[i]]] *= (if ys[eip[i]].isAlphaAscii: (if registers[i].contains(ys[eip[i]]): registers[i][ys[eip[i]]] else: 0) else: ys[eip[i]].parseInt)
            of "mod":
                if not registers[i].contains(xs[eip[i]]):
                    registers[i][xs[eip[i]]] = 0
                registers[i][xs[eip[i]]] =  registers[i][xs[eip[i]]] mod (if ys[eip[i]].isAlphaAscii: (if registers[i].contains(ys[eip[i]]): registers[i][ys[eip[i]]] else: 0) else: ys[eip[i]].parseInt)
            of "rcv":
                    if queue[i].len > 0:
                        registers[i][xs[eip[i]]] = queue[i].popFirst
                    else:
                        wait[i] = true
                        break
            of "jgz":
                if xs[eip[i]].isAlphaAscii and not registers[i].contains(xs[eip[i]]):
                    registers[i][xs[eip[i]]] = 0
                if ys[eip[i]].isAlphaAscii and not registers[i].contains(ys[eip[i]]):
                    registers[i][ys[eip[i]]] = 0
                if (xs[eip[i]].isAlphaAscii and registers[i][xs[eip[i]]] > 0) or (not xs[eip[i]].isAlphaAscii and xs[eip[i]].parseInt > 0):
                    eip[i] += (if ys[eip[i]].isAlphaAscii: registers[i][ys[eip[i]]] else: ys[eip[i]].parseInt)
                    continue
            inc(eip[i])

echo(ans)