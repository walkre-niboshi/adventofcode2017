import strutils

var
    listA = newSeq[int]()
    listB = newSeq[int]()
    a = readLine(stdin).split()[4].parseInt
    b = readLine(stdin).split()[4].parseInt
while listA.len < 5000000:
    a = a*16807 mod 2147483647
    if a mod 4 == 0:
        listA.add(a)

while listB.len < 5000000:
    b = b*48271 mod 2147483647
    if b mod 8 == 0:
        listB.add(b)

var count = 0
for i in 0..5000000-1:
    if (listA[i] and ((1 shl 16)-1)) == (listB[i] and ((1 shl 16)-1)):
        inc(count)

echo(count)