{$R+}
const
     fi='newton.inp';
     fo='newton.out';
var
   n,m,c,snh,at,atmax:integer;
   md,cd,nh:array[1..100] of integer;
   cm,cc,tam:array[1..100,1..100] of integer;
   ddht,dddn:array[0..100] of byte;
   chua:array[1..100] of boolean;
   f:text;
procedure nhap;
var
   x,y:integer;
begin
assign(f,fi);reset(f);
readln(f,n,m,c);
fillchar(cm,sizeof(cm),0);
fillchar(cc,sizeof(cc),0);
repeat
readln(f,x,y);
if x<>-1 then cm[x,y]:=1;
until (x=-1);
while not(eof(f)) do
      begin
      readln(f,x,y);cc[x,y]:=1;
      end;
close(f);
end;
procedure loangm(i:integer);
var
   j:integer;
begin
for j:=1 to n do
    if (md[j]=0)and(cm[i,j]=1) then
       begin
       md[j]:=1;
       loangm(j);
       end;
end;
procedure xetm;
begin
fillchar(md,sizeof(md),0);md[m]:=1;
loangm(m);
end;
procedure loangc(i:integer);
var
   j:integer;
begin
for j:=1 to n do
    if (cd[j]=0)and(cc[i,j]=1) then
       begin
       cd[j]:=1;
       loangc(j);
       end;
end;
procedure xetc;
begin
fillchar(cd,sizeof(cd),0);cd[c]:=1;
loangc(c);
end;
procedure cau1;
var
   i:integer;
begin
xetc;xetm;
fillchar(nh,sizeof(nh),0);snh:=0;
for i:=1 to n do
{    if (md[i]=1)and(cd[i]=1) then begin nh[i]:=1;inc(snh);end;}
    if (md[i]*cd[i]=1) then begin nh[i]:=1;inc(snh);end;
assign(f,fo);rewrite(f);
writeln(f,snh);
if snh>0 then for i:=1 to n do if nh[i]=1 then writeln(f,i);
close(f);
end;
procedure loai;
var
   i,j:integer;
begin
for i:=1 to n do if md[i]=1 then
    for j:=1 to n do if cc[j,i]=1 then cc[j,i]:=0;
end;
function cothe(x:integer):boolean;
var
   cqua:array[1..100] of boolean;
   p,q:integer;
   procedure di(y:integer);
   var
      r,s:integer;
   begin
   for r:=1 to n do if cqua[r] and(cc[y,r]=1) then
       begin cqua[r]:=false;di(r);end;
   end;
begin
fillchar(cqua,sizeof(cqua),true);
cqua[x]:=false;di(x);
cothe:=not(cqua[c]);
end;
procedure find;
var l,j: integer;
begin
l:=ddht[ddht[0]];
for j:=1 to N do if chua[j] and(cc[l,j]=1) then
begin
ddht[0]:=ddht[0]+1;ddht[ddht[0]]:=j;
if (ddht[0]>dddn[0])and cothe(ddht[ddht[0]]) then dddn:=ddht;
chua[j]:=false;find;
chua[j]:=true;ddht[0]:=ddht[0]-1;
end;
if (ddht[0]>dddn[0])and cothe(ddht[ddht[0]]) then dddn:=ddht;
end;
procedure cau2;
var
   i:integer;
begin
loai;
fillchar(chua,sizeof(chua),true);
dddn[0]:=1; dddn[1]:=c;
ddht[0]:=1; ddht[1]:=c;chua[c]:=false;find;
assign(f,fo);append(f);
if dddn[0]=1 then writeln(f,0)
else
    begin
    writeln(f,1);writeln(f,dddn[0]);
    for i:=1 to dddn[0] do writeln(f,dddn[i]);
    end;
close(f);
end;
BEGIN
nhap;cau1;cau2;
END.