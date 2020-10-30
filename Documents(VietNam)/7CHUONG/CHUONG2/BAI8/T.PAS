const
     fi='nc.i';
var
   f:text;t:char;
   max,m,n,i,j:word;
begin
max:=0;
for t:='1' to '5' do
    begin
    m:=0;
    assign(f,fi+t);reset(f);
    while not(seekeof(f)) do
          begin
          n:=0;
          while not(seekeoln(f)) do begin read(f,i);inc(n);end;
          readln(f);
          if n>m then m:=n;
          end;
    close(f);
    if m>max then max:=m;
    end;
writeln(max);readln;
end.