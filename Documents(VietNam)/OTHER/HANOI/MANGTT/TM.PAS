{$R+}
uses crt;
const
     fi='mtt4.inp';
     n=10;sc=20;
var
   f:text;
   dem,j,i,u,v:byte;nn:real;
   dem1:longint;t:real;
   a:array[1..20,1..20] of real;
function lt:boolean;
var
   tp:array[1..20] of byte;
   c,z:byte;
procedure di(x:byte);
var
   y:byte;
begin
tp[x]:=c;
for y:=1 to n do if (tp[y]=0)and(a[x,y]>0) then di(y);
end;
begin
fillchar(tp,sizeof(tp),0);c:=0;
for z:=1 to n do if tp[z]=0 then begin inc(c);di(z);end;
lt:=(c=1);
end;
BEGIN
randomize;
assign(f,fi);rewrite(f);
write(f,n:5);
repeat
u:=random(n)+1;v:=random(n)+1;
until u<>v;
writeln(f,u:5,v:5);
repeat
dem:=0;
fillchar(a,sizeof(a),0);
for i:=2 to n do
for j:=1 to i-1 do
    begin
    t:=random;
    if (t>1/2) then
    begin a[i,j]:=t;a[j,i]:=a[i,j];inc(dem);end
    else begin a[i,j]:=0;a[j,i]:=a[i,j];end;
    end;
until lt and (dem<=sc);
for i:=1 to n do a[i,i]:=1;
for i:=1 to n do
begin
for j:=1 to i do write(f,a[i,j]:8:6,' ');
writeln(f);
end;
close(f);
END.