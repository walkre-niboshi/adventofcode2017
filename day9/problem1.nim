import strutils

let stream = readLine(stdin)
var
    i, score = 0
    nest = 1
    inGarbage = false

while i < stream.len:
    if stream[i] == '!':
        i += 2
        continue

    if inGarbage:
        if stream[i] == '>':
            inGarbage = false
            inc(i)
            continue
        inc(i)
    else:
        if stream[i] == '<':
            inGarbage = true
            inc(i)
            continue
        if stream[i] == '{':
            score += nest
            inc(nest)
            inc(i)
            continue
        if stream[i] == '}':
            dec(nest)
            inc(i)
            continue
        inc(i)

echo(score)