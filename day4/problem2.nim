import strutils
import sets
import algorithm

proc isValidPassphrase(passphrase: seq[string]): bool =
    var used = initSet[string]()
    for word in passphrase:
        var sortedWord = word
        sortedWord.sort(cmp)

        if used.contains(sortedWord):
            return false
        used.incl(sortedWord)
    return true

var validPassphrase = 0

while true:
    var input: string
    try:
        input = readLine(stdin)
    except IOError:
        break
    
    if isValidPassphrase(input.split()):
        inc(validPassphrase)

echo validPassphrase