import strutils
import sets

proc isValidPassphrase(passphrase: seq[string]): bool =
    var used = initSet[string]()
    for word in passphrase:
        if used.contains(word):
            return false
        used.incl(word)
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