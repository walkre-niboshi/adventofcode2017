import strutils, sequtils, tables

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
    eip = 0
    sound = -1
    registers = initTable[string, int]()
while eip < instructions.len:
    case instructions[eip]:
    of "snd":
        sound = registers[xs[eip]]
    of "set":
        registers[xs[eip]] = if ys[eip].isAlphaAscii: (if registers.contains(ys[eip]) : registers[ys[eip]] else: 0) else: ys[eip].parseInt
    of "add":
        if not registers.contains(xs[eip]):
            registers[xs[eip]] = 0
        registers[xs[eip]] += (if ys[eip].isAlphaAscii: (if registers.contains(ys[eip]) : registers[ys[eip]] else: 0) else: ys[eip].parseInt)
    of "mul":
        if not registers.contains(xs[eip]):
            registers[xs[eip]] = 0
        registers[xs[eip]] *= (if ys[eip].isAlphaAscii: (if registers.contains(ys[eip]) : registers[ys[eip]] else: 0) else: ys[eip].parseInt)
    of "mod":
        if not registers.contains(xs[eip]):
            registers[xs[eip]] = 0
        registers[xs[eip]] =  registers[xs[eip]] mod (if ys[eip].isAlphaAscii: (if registers.contains(ys[eip]) : registers[ys[eip]] else: 0) else: ys[eip].parseInt)
    of "rcv":
        if xs[eip].isAlphaAscii and not registers.contains(xs[eip]):
            registers[xs[eip]] = 0
        if (xs[eip].isAlphaAscii and registers[xs[eip]] != 0) or (not xs[eip].isAlphaAscii and xs[eip].parseInt != 0):
            echo(sound)
            break
    of "jgz":
        if xs[eip].isAlphaAscii and not registers.contains(xs[eip]):
            registers[xs[eip]] = 0
        if ys[eip].isAlphaAscii and not registers.contains(ys[eip]):
            registers[ys[eip]] = 0
        if (xs[eip].isAlphaAscii and registers[xs[eip]] > 0) or (not xs[eip].isAlphaAscii and xs[eip].parseInt > 0):
            eip += (if ys[eip].isAlphaAscii: registers[ys[eip]] else: ys[eip].parseInt)
            continue
    inc(eip)