{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R-,S+,T-,V+,X+}
{$M 63535,0,655360}
const
fi='chess.in3';
fo='chess.out';
max=65535;
type
arr=array[1..65535] of byte;
arr1=array[1..16] of byte;

var a:^arr;
    b:arr1;
    s1,s2,s,dem:word;
    j:byte;
    f,g:text;
procedure init;
begin
fillchar(a^,sizeof(a^),0);
end;
procedure  mang(s:word;var c:arr1);
var i:byte;
begin
fillchar(c,sizeof(c),0);
for i:=1 to 16 do
 c[i]:=(s shr (16-i))and 1;
end;
function so(b:arr1):word;
var i:byte;
    tg:word;
begin
tg:=0;
for i:=1 to 16 do
tg:=tg+(b[i] shl (16-i));
so:=tg;
end;

function left(b:arr1;s:word;i:byte):word;
begin
left:=s;
if i mod 4=1 then exit;
if b[i-1]=0 then
 begin
  b[i]:=0;
  b[i-1]:=1;
  left:=so(b);
 end;

end;
function right(b:arr1;s:word;i:byte):word;
begin
right:=s;
if i mod 4=0 then exit;
mang(s,b);
if b[i+1]=0 then
 begin
  b[i]:=0;
  b[i+1]:=1;
  right:=so(b);
 end;

end;
function up(b:arr1;s:word;i:byte):word;
begin
up:=s;
if (i-1) div 4=0 then exit;
mang(s,b);
if b[i-4]=0 then
 begin
  b[i]:=0;
  b[i-4]:=1;
  up:=so(b);
 end;
end;
function down(b:arr1;s:word;i:byte):word;
begin
down:=s;
if (i-1) div 4=3 then exit;
mang(s,b);
if b[i+4]=0 then
 begin
  b[i]:=0;
  b[i+4]:=1;
  down:=so(b);
 end;

end;

procedure nhap;
var i,d,k:byte;
    j:char;
begin
assign(f,fi);
reset(f);
s1:=0;
s2:=0;
d:=0;
for i:=1 to 16 do
 begin
  read(f,j);
  if j='1' then
   begin
    inc(d);
    s1:=s1+ 1 shl (16-i);
   end;
  if i mod 4=0 then readln(f);
 end;
for i:=1 to 16 do
 begin
  read(f,j);
  if j='1' then
   begin
    dec(d);
    s2:=s2+1 shl (16-i);
   end;
  if i mod 4=0 then readln(f);
 end;
if d<>0 then
 begin
  write(g,0);
  close(g);
  halt;
 end;
close(f);
end;

procedure loang;
var i,d,c :word;
    ok:boolean;
begin
dem:=1;
d:=s1;
c:=s1;
repeat
ok:=true;
inc(dem);
a^[s1]:=1;
for i:=d to c do
 if a^[i]=dem-1 then
  begin
   mang(i,b);
   for j:=1 to 16 do
    if b[j]=1 then
     begin
      s:=left(b,i,j);
      if a^[s]=0 then begin a^[s]:=dem; ok:=false;if s<d then d:=s; if s>c then c:=s; end;

      s:=right(b,i,j);
      if a^[s]=0 then begin a^[s]:=dem; ok:=false;if s<d then d:=s; if s>c then c:=s; end;

      s:=up(b,i,j);
      if a^[s]=0 then begin a^[s]:=dem; ok:=false;if s<d then d:=s; if s>c then c:=s; end;

      s:=down(b,i,j);
      if a^[s]=0 then begin a^[s]:=dem; ok:=false;if s<d then d:=s; if s>c then c:=s; end;
      if a^[s2]<>0 then exit;
     end;
  end;
until ok;
end;
procedure ghi(i:word;k:byte);
var j:byte;
begin
 if i=s1 then exit;
 mang(i,b);
   for j:=16 downto 1 do
    if b[j]=1  then
     begin
      s:=left(b,i,j);
      if a^[s]=k-1 then
       begin
         ghi(s,k-1);
         writeln(g,(j-1)div 4 +1,' ',(j-1)mod 4,' ', (j-1)div 4 +1,' ',(j-1)mod 4 +1);
         exit;
       end;
      s:=right(b,i,j);
      if a^[s]=k-1 then
       begin
         ghi(s,k-1);
         writeln(g,(j-1)div 4 +1,' ',(j-1)mod 4+2,' ', (j-1)div 4 +1,' ',(j-1)mod 4 +1);
         exit;
       end;
      s:=up(b,i,j);
      if a^[s]=k-1 then
       begin
         ghi(s,k-1);
         writeln(g,(j-1)div 4,' ',(j-1)mod 4+1,' ', (j-1)div 4 +1,' ',(j-1)mod 4 +1);
         exit;
       end;
      s:=down(b,i,j);
      if a^[s]=k-1 then
       begin
         ghi(s,k-1);
         writeln(g,(j-1)div 4+2,' ',(j-1)mod 4+1,' ', (j-1)div 4 +1,' ',(j-1)mod 4 +1);
         exit;
       end;
    end;
end;

begin
assign(g,fo);
rewrite(g);
new(a);
init;
nhap;
loang;
if a^[s2]=0 then write(g,0) else
 begin
 writeln(g,a^[s2]-1);
 ghi(s2,dem);
 end;
dispose(a);
close(g);
end.
