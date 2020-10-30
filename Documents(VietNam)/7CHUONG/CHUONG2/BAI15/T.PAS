uses crt;
const
     n=60;m=100;
     fi1='td1.in';
     fi2='td2.in';
var
   g:array[1..n] of longint;
   i,j,k,x,y:longint;
   f:text;t:char;
BEGIN
randomize;
for t:='0' to '9' do
    begin
{    for i:=1 to n do g[i]:=1+random(200);}
    assign(f,fi1+t);rewrite(f);
    for j:=1 to m do
        begin
        repeat
        x:=1+random(n);y:=1+random(n);
        until x<>y;
        writeln(f,x:3,y:3,1+random(200):4,1+random(200):4);
        end;
    close(f);
    assign(f,fi2+t);rewrite(f);
    for j:=1 to 100 do
        begin
        x:=1+random(n);y:=1+random(n);
        writeln(f,x:3,y:3);
        end;
    close(f);
    end;
END.