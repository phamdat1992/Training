uses crt;
const
     n=50;
var
   i,j,h:byte;code:integer;
   f:text;k:char;fi:string;
begin
randomize;
for k:='0' to '9' do
begin
val(k,i,code);
fi:='luoi.in'+k;
assign(f,fi);rewrite(f);
writeln(f,n:4,n:4);
for i:=1 to n do
    begin
    for j:=1 to n do
        begin
        h:=random(2);
        if h=0 then write(f,random(16):4) else write(f,random(8):4);
        end;
    writeln(f);
    end;
close(f);
end;
end.