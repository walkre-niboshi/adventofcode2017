import strutils, algorithm

var severity = 0
while true:
    try:
        let
            input = readLine(stdin)
            dep = input.replace(":").split()[0].parseInt
            ran = input.replace(":").split()[1].parseInt
        if min(dep mod (ran*2-2), ran*2-2-(dep mod (ran*2-2))) == 0:
            severity += dep*ran 
    except IOError:
        break

echo(severity)