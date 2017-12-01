let str:string=readLine(stdin)
let half_len:int=len(str) div 2
var sum:int=0
for i in countup(0,len(str)-1):
    if str[i]==str[(i+half_len) mod len(str)]:
        sum+=int(str[i])-int('0')
echo sum