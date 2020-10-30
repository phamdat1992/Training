const
     fo='nt.t';
var
   f:text;
   m,dau,z,j:extended;n,dem,code:integer;
function chiahet(x,y:extended):Boolean;
begin
chiahet:=(frac(x/y)=0);
end;
function p(x:extended):boolean;
var y,j:extended;
begin
p:=true;
if (x<=1) then begin p:=false;exit;end;
if x<4 then exit;
if chiahet(x,2) then begin p:=false;exit;end;
if chiahet(x,3) then begin p:=false;exit;end;
if x<25 then exit;
y:=5;j:=2;
while y*y<=x do
if chiahet(x,y) then begin p:=false;exit;end
else begin y:=y+j;j:=6-j;end;
end;
BEGIN
assign(f,fo);rewrite(f);
write(f,'(');dem:=0;
for n:=1 to 1000 do if p(n) then
    begin
    inc(dem);
    write(f,n,',');
    if dem mod 20 = 0 then writeln(f);
    end;
writeln(f);
close(f);
END.