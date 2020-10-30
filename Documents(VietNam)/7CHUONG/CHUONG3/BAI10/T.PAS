uses crt;
const
     n=10;k=15;
     fi='bi.in5';
var
   i,j,u,v:byte;
   a:array[1..100,1..100] of byte;
   f:text;duoc:boolean;
   bi:array[1..k,1..2] of byte;
begin
randomize;
fillchar(a,sizeof(a),0);
bi[1,1]:=1+random(n);bi[1,2]:=1+random(n);
for i:=2 to k do
    begin
    repeat
    duoc:=true;
    u:=1+random(n);v:=1+random(n);
    for j:=1 to i-1 do if (bi[j,1]=u)and(bi[j,2]=v) then
        begin duoc:=false;break;end;
    until duoc;
    bi[i,1]:=u;bi[i,2]:=v;
    end;
for i:=1 to k do a[bi[i,1],bi[i,2]]:=1+random(2);
assign(f,fi);rewrite(f);
writeln(f,n);
for i:=1 to n do
    begin
    for j:=1 to n do write(f,a[i,j]:2);writeln(f);
    end;
writeln(f,1+random(n));
close(f);
end.