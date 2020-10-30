uses crt;
var
   n,k,i,j,u,test:integer;s:string;
   f:text;
   a:array[1..50,1..50] of integer;
begin
randomize;
for u:=3 to 5 do
    begin
    str(u,s);n:=10*u;k:=u*9;
    assign(f,'mgt'+s+'.dat');rewrite(f);
    writeln(f,n:5,k:5);
    for i:=1 to u do
    for j:=1 to 9 do writeln(f,10*(i-1)+1:5,10*(i-1)+1+j:5);
    fillchar(a,sizeof(a),0);
    for i:=1 to n-1 do
    for j:=i+1 to n do
        begin
        a[i,j]:=1+random(200);
        a[j,i]:=a[i,j];
        end;
    for i:=1 to n do
    begin
    for j:=1 to n do write(f,a[i,j]:5);writeln(f);
    end;
    close(f);
    end;
end.