uses crt;
var
   f:text;
   i:word;
begin
randomize;
assign(f,'gnt.inp');rewrite(f);
for i:=1 to 50 do writeln(f,10+random(491));
close(f);
end.