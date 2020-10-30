const
     fo='c.txt';
var
   f:text;
   q,dau,n,z,j:extended;dem,code:integer;
function chiahet(x,y:extended):Boolean;
begin
chiahet:=(frac(x/y)=0);
end;
function ghep(x,y:extended):extended;
var u,v:extended;
begin
u:=10;v:=y;
while v>=10 do
      begin
      u:=u*10;v:=v/10;
      end;
ghep:=x*u+y;
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
write(f,23);
n:=5;dem:=1;j:=2;
while (dem<=500) do
if p(n) then
   begin
   dau:=n;
   repeat n:=n+j;j:=6-j; until p(n);
   q:=ghep(dau,n);
   if p(q) then
   begin
   inc(dem);
   writeln(f,q:0:0);
   end;
   n:=n+j;j:=6-j;
   end
else begin n:=n+j;j:=6-j;end;
close(f);
END.