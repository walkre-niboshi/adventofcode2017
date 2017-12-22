import strutils, sequtils

proc flip(square: seq[string]): seq[string] =
    result = square
    for i in 0..square.high:
        for j in 0..square[i].len div 2-1:
            result[i][j].swap(result[i][square[i].high-j])

proc rotate(square: seq[string]): seq[string] =
    let size = square.len
    result = newSeqWith(size, newString(size))
    for i in 0..square.high:
        for j in 0..square[i].high:
            result[size-1-j][i] = square[i][j]

proc match(square, pattern: seq[string]): bool =
    if square.len != pattern.len:
        return false
    
    for i in 0..3:
        var tmp = pattern
        for j in 0..i:
            tmp = rotate(tmp)
        if square == tmp:
            return true
    
    let flipped = flip(pattern)
    for i in 0..3:
        var tmp = flipped 
        for j in 0..i:
            tmp = rotate(tmp)
        if square == tmp:
            return true
    return false
 
type
    Rule = tuple[src, dst: seq[string]]

proc convert(square: seq[string]; rules: seq[Rule]): seq[string] =
    for rule in rules:
        if square.match(rule.src):
           return rule.dst 

proc breakUp(square: seq[string], size: int): seq[seq[seq[string]]] = 
    result = newSeqWith(square.len div size, newSeq[seq[string]](square.len div size))
    for i in 0..result.high:
        for j in 0..result[i].high:
            result[i][j] = newSeqWith(size, newString(size))
            for i2 in 0..size-1:
                for j2 in 0..size-1:
                    result[i][j][i2][j2] = square[i*size+i2][j*size+j2]

proc enhance(square: seq[string], rules: seq[Rule]): seq[string] =
    let size = square.len
    if size mod 2 == 0:
        result = newSeqWith(size div 2*3, newString(size div 2*3))
        let broken = square.breakUp(2)
        for i in 0..broken.high:
            for j in 0..broken.high:
                let converted = broken[i][j].convert(rules)
                for i2 in 0..converted.high:
                    for j2 in 0..converted[i2].high:
                        result[i*3+i2][j*3+j2] = converted[i2][j2]
    else:
        result = newSeqWith(size div 3*4, newString(size div 3*4))
        let broken = square.breakUp(3)
        for i in 0..broken.high:
            for j in 0..broken.high:
                let converted = broken[i][j].convert(rules)
                for i2 in 0..converted.high:
                    for j2 in 0..converted[i2].high:
                        result[i*4+i2][j*4+j2] = converted[i2][j2]

var rules = newSeq[Rule]()
while true:
    try:
        let input = stdin.readLine.replace("/", " ").split
        var rule: Rule = (newSeq[string](), newSeq[string]())
        for i in 0..input.find("=>")-1:
            rule.src.add(input[i])
        for i in input.find("=>")+1..input.high:
            rule.dst.add(input[i])
        rules.add(rule)
    except IOError:
        break

var square = @[".#.", "..#", "###"]
for i in 1..5:
    square = square.enhance(rules)

echo(square.concat.foldl(a&b).count('#'))
