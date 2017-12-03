import strutils

let p = readLine(stdin).parseInt

if p == 1:
    echo 0
else:
    var i = 1
    while true:
        if i*i < p and p <= (i+2)*(i+2):
            var minDist = 1000000000
            for j in countup(0, 3):
                minDist = min(minDist, abs(p-(i*i+(i div 2+1)+j*(i+1))))
            minDist += i div 2+1
            echo minDist
            break
            
        i += 2