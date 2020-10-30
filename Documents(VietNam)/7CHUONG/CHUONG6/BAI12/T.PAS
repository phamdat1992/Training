uses crt;
const
     fi='piton.in4';
     h:array[1..4] of char=('L','R','D','U');
     n=50;
var
   chon,dem,m,i,j,u,v:word;f:text;duoc:boolean;
   tho:array[1..50,1..2] of word;
begin
clrscr;
randomize;
assign(f,fi);rewrite(f);
m:=10+random(20);
writeln(f,n:5,m:5);
writeln(f,20:5,20:5,21:5,20:5);
for i:=1 to m do
    begin
    repeat
    duoc:=true;
    repeat
    u:=1+random(50);v:=1+random(50);
    until ((u<20)and(v<20))or((u>21)and(v>21));
    if i>1 then for j:=1 to i-1 do
       if (tho[j,1]=u)and(tho[j,2]=v) then begin duoc:=false;break;end;
    until duoc;
    tho[i,1]:=u;tho[i,2]:=v;
    end;
for i:=1 to m do writeln(f,tho[i,1]:5,tho[i,2]:5,random(11):5);
dem:=0;
repeat
chon:=1+random(4);inc(dem);
writeln(f,h[chon]:5,1+random(5):5);
until dem>=995;
close(f);
end.