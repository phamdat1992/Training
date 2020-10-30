uses crt;
const
     n=100;
     fi='ch.';
var
   f:text;t1,t2,t3:char;
   u,i,j:word;k:longint;
BEGIN
randomize;
for t1:='0' to '9' do
for t2:='0' to '9' do
for t3:='0' to '9' do
    begin
    assign(f,fi+t1+t2+t3);rewrite(f);
    writeln(f,n);
    for i:=1 to n-1 do
    for j:=i+1 to n do
        begin
        k:=random(2);
        if k=1 then writeln(f,i:4,j:4,10+random(1000):10);
        end;
    close(f);
    end;
END;
