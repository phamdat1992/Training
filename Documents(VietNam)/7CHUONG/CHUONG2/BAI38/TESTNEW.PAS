{$R+}
uses crt;
const
     n=20;
     fi='newton5.inp';
var
   x1,y1,x,y,i,j,k,m,c:byte;
   sm,sc:byte;
   cm:array[1..100,1..2] of byte;
   cc:array[1..100,1..2] of byte;
   duoc:boolean;f:text;
begin
randomize;
assign(f,fi);rewrite(f);
repeat
m:=1+random(20);
c:=1+random(20);
until m<>c;
writeln(f,n:5,m:5,c:5);
sm:=10+random(60);
repeat
x:=1+random(n);
y:=1+random(n);
until x<>y;
writeln(f,x:5,y:5);
cm[1,1]:=x;cm[1,2]:=y;
for i:=2 to sm do
    begin
    repeat
    x:=1+random(n);
    repeat
    y:=1+random(n);
    until (x<>y)and(y<>c);
    duoc:=true;
    for j:=1 to i-1 do
        if (cm[j,1]=x)and(cm[j,2]=y) then begin duoc:=false;break;end;
    until duoc;
    writeln(f,x:5,y:5);
    cm[i,1]:=x;cm[i,2]:=y;
    end;
writeln(f,-1:5,-1:5);
sc:=10+random(60);
repeat
x:=1+random(n);
y:=1+random(n);
until x<>y;
writeln(f,x:5,y:5);
cc[1,1]:=x;cc[1,2]:=y;
for i:=2 to sc do
    begin
    repeat
    x:=1+random(n);
    repeat
    y:=1+random(n);
    until (x<>y);
    duoc:=true;
    for j:=1 to i-1 do
        if (cc[j,1]=x)and(cc[j,2]=y) then begin duoc:=false;break;end;
    until duoc;
    writeln(f,x:5,y:5);
    cc[i,1]:=x;cc[i,2]:=y;
    end;
close(f);
end.