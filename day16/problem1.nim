import strutils

proc toString(str: seq[char]): string =
    result = newStringOfCap(len(str))
    for ch in str:
      add(result, ch)

var programs = newSeq[char](16)
for c in 'a'..'p':
    programs[ord(c)-ord('a')] = c

let moves = stdin.readLine.split(",")
for move in moves:
    case move[0]:
    of 's':
        let num = move.substr(1).parseInt
        programs = programs[15-num+1..15]&programs[0..15-num]
    of 'x':
        let
            positionA = move.substr(1).replace("/", " ").split()[0].parseInt
            positionB = move.substr(1).replace("/", " ").split()[1].parseInt
        programs[positionA].swap(programs[positionB])
    of 'p':
        let
            positionA = programs.find(move.substr(1).replace("/", " ").split()[0][0])
            positionB = programs.find(move.substr(1).replace("/", " ").split()[1][0])
        programs[positionA].swap(programs[positionB])
    else:
        discard

echo(toString(programs))
