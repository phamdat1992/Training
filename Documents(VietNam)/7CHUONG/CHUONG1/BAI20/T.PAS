uses crt;
const
     fi='robot.in';
     n=100;
     m:array['0'..'9'] of word=(400,800,1200,1600,2000,2400,2800,3200,3600,4000);
var
   f:text;
   t:char;i,j,dem:word;
   a:array[1..100,1..100]0] of byte;
BEGIN
randomize;
for t:='0' to '9' do
    begin
    assign(f,fi+t);rewrite(f);
    writeln(f,n:5,n:5);
    dem:=0;
    repeat
    i:=random(n)+1;j:=random(n)+1;
    a[i,j]:=random(2);
    if a[i,j]=1 then inc(dem);
    until dem=m[t];
    for i:=1 to n do
    begin
    for j:=1 to n do write(f,a[i,j]:2);writeln(f);
    end;
    close(f);
    end;
EN