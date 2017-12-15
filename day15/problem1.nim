import strutils

var
    a = readLine(stdin).split()[4].parseInt
    b = readLine(stdin).split()[4].parseInt
    count = 0
for i in 0..5000000:
    a = a*16807 mod 2147483647
    b = b*48271 mod 2147483647
    if (a and ((1 shl 16)-1)) == (b and ((1 shl 16)-1)):
        inc(count)
echo(count)