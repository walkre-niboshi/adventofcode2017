let c = 122700
var
    b = 105700
    h = 0

while true:
    var
        d = 2
        f = 1
    while true:
        if b mod d == 0:
            f=0
        inc(d)
        if d == b:
            break
    if f == 0:
        inc(h)
    if b == c:
        echo(h)
        break
    b += 17