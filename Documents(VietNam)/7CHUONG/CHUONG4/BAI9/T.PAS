uses crt;
const
     fi='vuon.in5';
     n=600;
var
   cay:array[1..600,1..2] of word;
   x,y,i,j,k:word;duoc:boolean;
   f:text;
begin
randomize;
assign(f,fi);rewrite(f);
writeln(f,n);
x:=1+random(1000);y:=1+random(1000);
writeln(f,x:5,y:5);
cay[1,1]:=x;cay[1,2]:=y;
for i:=2 to n do
    begin
    repeat
    duoc:=true;
    x:=1+random(1000);y:=1+random(1000);
    for j:=1 to i-1 do if (cay[j,1]=x)and(cay[j,2]=y) then
        begin duoc:=false;break;end;
    until duoc;
    writeln(f,x:5,y:5);
    cay[i,1]:=x;cay[i,2]:=y;
    end;
close(f);
end.
