uses crt;
const
     n=200;
     fi='ch.in';
var
   f:text;t:char;
   u,i,j,k:word;
BEGIN
randomize;
for t:='1' to '5' do
    begin
    assign(f,fi+t);rewrite(f);
    writeln(f,n);
    for i:=1 to n-1 do
    for j:=i+1 to n do
        begin
        k:=random(2);
        if k=1 then writeln(f,i:4,j:4,10+random(9000):10);
        end;
    close(f);
    end;
END.