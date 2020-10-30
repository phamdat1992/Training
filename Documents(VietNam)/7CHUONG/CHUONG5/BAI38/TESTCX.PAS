uses crt;
const
     fi='vitri.in6';
     n=50;
     k=10;
var
   i,j:byte;
   x,y:word;
   f:text;
begin
randomize;
assign(f,fi);rewrite(f);
writeln(f,n:5,k:5);
i:=0;x:=0;
while i<n do
    begin
    inc(i);
    x:=x+10+random(150);
    write(f,x:6);
    end;
writeln(f);
close(f);
end.