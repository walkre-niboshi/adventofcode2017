
import strutils
import sequtils
import tables

proc redistribute(banks: var seq[int]) =
    let max_value = max(banks)
    var max_index: int
    for i in 0 .. banks.high:
        if banks[i]==max_value:
            max_index = i
            break
    
    banks[max_index] = 0
    for i in 0..max_value-1:
        inc(banks[(max_index+i+1) mod banks.len])

var
    banks = readLine(stdin).split().map(parseInt)
    states = initTable[seq[int],int]()
    loop = 0
states[banks] = 0

while true:
    inc(loop)
    redistribute(banks)
    if states.contains(banks):
        echo(loop-states[banks])
        break
    states[banks] = loop