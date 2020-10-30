uses crt;
const
     n=1000;
     fi='input.tx';
var
   i:word;t:char;
   f:text;
BEGIN
randomize;
for t:='1' to '5' do
    begin
    assign(f,fi+t);rewrite(f);
    writeln(f,n);
    for i:=1 to 1000 do writeln(f,1+random(3));
    close(f);
    end;
END.