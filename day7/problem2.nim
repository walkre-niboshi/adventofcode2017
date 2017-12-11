import strutils
import sets
import tables

type Node = tuple[weight: int, children: seq[string]]

proc getTower(): (Table[string, Node], string) = 
    var
        programs = initSet[string]()
        notBottom = initSet[string]()
        tower = initTable[string, Node]()
    while true:
        try:
            let
                input = readLine(stdin).split()
                bottom = input[0]
            programs.incl(bottom)

            tower[bottom] = (0, newSeq[string]())
            tower[bottom].weight = input[1].replace("(").replace(")").parseInt
            
            for i in 3 .. input.high:
                let program = input[i].replace(",")
                notBottom.incl(program)
                tower[bottom].children.add(program)

        except IOError:
            break

    for program in programs:
        if not notBottom.contains(program):
            result = (tower, program)
            break

proc weightOfTower(tower: Table[string, Node], bottom: string): int =
    result = tower[bottom].weight
    for child in tower[bottom].children:
        result += weightOfTower(tower, child)

proc calcDiff(tower: Table[string, Node], bottom: string): int =
    var weight = -1
    for child in tower[bottom].children:
        let w = weightOfTower(tower, child)
        if weight == -1:
            weight = w
        elif weight != w:
            return abs(weight-w)

proc isBalanced(tower: Table[string, Node], bottom: string): bool =
    if tower[bottom].children.len == 0:
        return true
    
    var weight = -1
    for child in tower[bottom].children:
        if not isBalanced(tower, child):
            return false

        let w = weightOfTower(tower, child)
        if weight == -1:
            weight = w
        elif weight != w:
            return false
    
    return true


var (tower, bottom) = getTower()
let diff = calcDiff(tower, bottom)

for program in tower.keys:
    tower[program].weight += diff
    if isBalanced(tower, bottom):
        echo(tower[program].weight)
        break
    
    tower[program].weight -= diff*2
    if isBalanced(tower, bottom):
        echo(tower[program].weight)
        break
    
    tower[program].weight += diff