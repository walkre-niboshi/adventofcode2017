import tables, sequtils

type Operation = tuple[write, move: int, next: string]

var states = initTable[string, seq[Operation]]()
states["A"] = @[(1, 1, "B"), (0, -1, "B")]
states["B"] = @[(1, -1, "C"), (0, 1, "E")]
states["C"] = @[(1, 1, "E"), (0, -1, "D")]
states["D"] = @[(1, -1, "A"), (1, -1, "A")]
states["E"] = @[(0, 1, "A"), (0, 1, "F")]
states["F"] = @[(1, 1, "E"), (1, 1, "A")]

var
    tape = initTable[int, int]()
    cursor = 0
    state = "A"

for i in 1..12861455:
    let value = tape.getOrDefault(cursor)
    tape[cursor] = states[state][value].write
    cursor += states[state][value].move
    state = states[state][value].next

var count = 0
for p in tape.pairs:
    count += p[1]
echo(count)