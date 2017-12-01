let str: string = readLine(stdin)
var sum: int = 0
for i in countup(0, len(str)-1):
    if str[i] == str[(i+1) mod len(str)]:
        sum += int(str[i])-int('0')
echo sum