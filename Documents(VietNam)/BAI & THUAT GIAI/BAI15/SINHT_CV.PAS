uses crt;
const
     fi='job.in';
     n:array['1'..'5'] of longint=(600,700,800,900,1000);
var
   f:text;t:char;
   i,j,k:longint;
BEGIN
randomize;
for t:='1' to '5' do
    begin
    assign(f,fi+t);rewrite(f);
    writeln(f,n[t]);
    for i:=1 to n[t] do
        writeln(f,1+random(60000):6,30000+random(35000):6);
    close(f);
    end;
END.