import strutils
import tables

var instructions = newSeq[seq[string]]()
while true:
    try:
        var input = readLine(stdin).split()
        input.delete(3)
        instructions.add(input)
    except IOError:
        break

proc condition(val: int, rel: string, k: int): bool =
    case rel
    of "<":
        return val < k
    of ">":
        return val > k
    of "<=":
        return val <= k
    of ">=":
        return val >= k
    of "==":
        return val == k
    of "!=":
        return val != k

var registers = initTable[string, int]()
for ins in instructions:
    if condition(registers.getOrDefault(ins[3]), ins[4], ins[5].parseInt):
        if not registers.hasKey(ins[0]):
            registers.add(ins[0], 0)
        if ins[1] == "inc":
            registers[ins[0]] += ins[2].parseInt
        else:
            registers[ins[0]] -= ins[2].parseInt

var ans = -1000000000
for v in registers.values:
    ans = max(ans, v)

echo(ans)