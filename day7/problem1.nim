import strutils
import sets

var
    programs = initSet[string]()
    notBottom = initSet[string]()
while true:
    try:
        let input = readLine(stdin).split()
        programs.incl(input[0])
        for i in 3 .. input.high:
            notBottom.incl(input[i].replace(","))
    except IOError:
        break

for program in programs:
    if not notBottom.contains(program):
        echo(program)
        break