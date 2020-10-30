uses crt;
const
     fo='subset.in1';
     lt:array[0..30] of longint=(1,2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,
     1048576,2097152,4194304,8388608,16777216,33554432,67108864,134217728,268435456,536870912,1073741824);
var
   t,yc,n,i,j,k,u,v:longint;
   a:array[0..30] of longint;
   f:text;duoc:boolean;
begin
randomize;
assign(f,fo);rewrite(f);
for i:=1 to 1000 do
    begin
    yc:=1+random(2);write(f,yc:2);
    n:=10+random(20);write(f,n:3);
    if yc=1 then
       begin
       repeat j:=100+random(50000);until j<=lt[n];
       writeln(f,j:10);
       end;
    if yc=2 then
       begin
       k:=random(n-1)+2;
       a[1]:=random(n)+1;;
       for j:=2 to k do
           begin
           repeat
           duoc:=true;
           u:=random(n)+1;
           for v:=1 to j-1 do if a[v]=u then begin duoc:=false;break;end;
           until duoc;
           a[j]:=u;
           end;
       for j:=1 to k-1 do
       for u:=j+1 to k do if a[j]>a[u] then
           begin v:=a[j];a[j]:=a[u];a[u]:=v;end;
       for j:=1 to k do write(f,a[j]:3);writeln(f);
       end;
    end;
close(f);
end.