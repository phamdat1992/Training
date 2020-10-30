const
     fi='gnt.inp';
     fo='gnt.out';
     dd:array[1..16] of extended=(23,3137,8389,157163,167173,233239,
     257263,331337,353359,467479,509521,523541,653659,661673,677683,727733);
var
   f,g:text;
   dau,n,z,j:extended;dem,m,max,i:integer;
   gnt:array[1..600] of extended;
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
procedure lam;
var
   q:extended;
begin
for i:=1 to 16 do gnt[i]:=dd[i];max:=16;
assign(f,fi);reset(f);
assign(g,fo);rewrite(g);
n:=735;
while not(seekeof(f)) do
      begin
      readln(f,m);
      if m<=max then writeln(g,gnt[m]:0:0)
      else
      begin
      dem:=max;j:=2;
      while (dem<m) do
      if p(n) then
         begin
         dau:=n;
         repeat n:=n+j;j:=6-j; until p(n);
         q:=ghep(dau,n);
         if p(q) then
            begin
            inc(dem);gnt[dem]:=q;
            if dem<m then begin n:=n+j;j:=6-j;end;
            end
         else begin n:=n+j;j:=6-j;end;
         end
      else begin n:=n+j;j:=6-j;end;
      writeln(g,q:0:0);
      n:=n+2;max:=dem;
      end;
      end;
close(f);close(g);
end;
BEGIN
lam;
END.
