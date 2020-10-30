uses crt;
const
     fi='dckt.in';
     n:array['1'..'5'] of word=(6000,7000,8000,9000,10000);
type
    day=array[1..10000] of word;
var
   a:day;
   f:text;t:char;
   i,j,k,u,v,tg:word;
procedure sinh;
var
	duoc:boolean;
begin
a[1]:=1+random(30000);
for i:=2 to n[t] do
    begin
    repeat
    duoc:=true;
	u:=1+random(60000);
    for j:=1 to i-1 do if a[j]=u then begin duoc:=false;break;end;
    until duoc;
    a[i]:=u;
    end;
end;
BEGIN
randomize;
for t:='1' to '5' do
	begin
    sinh;
    assign(f,fi+t);rewrite(f);
    for i:=1 to n[t] do writeln(f,a[i]);
    close(f);
    end;
END.