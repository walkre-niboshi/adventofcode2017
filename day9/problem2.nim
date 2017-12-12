import strutils

let stream = readLine(stdin)
var
    i, ans = 0
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
        inc(ans)
        inc(i)
    else:
        if stream[i] == '<':
            inGarbage = true
            inc(i)
            continue
        if stream[i] == '{':
            inc(i)
            continue
        if stream[i] == '}':
            inc(i)
            continue
        inc(i)

echo(ans)