import strutils, tables

proc toString(str: seq[char]): string =
    result = newStringOfCap(len(str))
    for ch in str:
      add(result, ch)

type
    ProgramPair = tuple[a: char, b: char]
proc makePermTable(moves: seq[string]): tuple[sx: seq[int], p: seq[ProgramPair]] =
    result[1] = newSeq[ProgramPair]()    
    var programs = newSeq[char](16)
    for c in 'a'..'p':
        programs[ord(c)-ord('a')]  = c
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
                programA = move.substr(1).replace("/", " ").split()[0][0]
                programB = move.substr(1).replace("/", " ").split()[1][0]
                pair:ProgramPair = (a: programA, b: programB)
            result[1].add(pair)
        else:
            discard
    
    result[0] = newSeq[int](16)
    for c in 'a'..'p':
        result[0][ord(c)-ord('a')] = programs.find(c)

let changes = makePermTable(stdin.readLine.split(","))
var programs = newSeq[char](16)
for c in 'a'..'p':
    programs[ord(c)-ord('a')] = c

for i in 1..1000000000:
    var tmp = newSeq[char](16)
    for j in 0..15:
        tmp[changes[0][j]] = programs[j]
    programs = tmp

var
    memo = initTable[seq[char], int]()
    memo2 = initTable[int, seq[char]]()
    loop = false
for i in 0..1000000000-1:
    memo[programs] = i
    memo2[i] = programs
    for pair in changes[1]:
        let
            positionA = find(programs, pair.a)
            positionB = find(programs, pair.b)
        programs[positionA].swap(programs[positionB])
    
    if memo.contains(programs):
        let j = memo[programs]
        echo(toString(memo2[j+(1000000000-j) mod (i+1-j)]))
        loop = true
        break
        
if not loop:
    echo(toString(programs))
