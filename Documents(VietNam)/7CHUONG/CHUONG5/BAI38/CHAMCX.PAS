{$R+}
uses crt;
const
     fhs='vitri.out';
var
   d:array[1..200] of word;
   lt:array[1..201] of word;
   cs:array[1..200] of byte;
   test,kc,kchs:word;
   fi,fo,s:string;
   n,k,khs:byte;
   f:text;
procedure nhap;
{Nhap du lieu tu file input}
var
   i:word;
begin
assign(f,fi);reset(f);
readln(f,n,k);
for i:=1 to n do read(f,d[i]);
lt[1]:=0;lt[n+1]:=0;
for i:=2 to n do lt[i]:=d[i]-d[i-1];
close(f);
assign(f,fo);reset(f);
{Doc khoang cach toi uu tu file Output chuan}
readln(f,kc);
close(f);
end;
procedure doc;
{Doc file ket qua cua hoc sinh}
var
   x:byte;
begin
fillchar(cs,sizeof(cs),0);
khs:=0;
{$I-}
assign(f,fhs);reset(f);
if IOResult<>0 then
   begin
   writeln('Khong co file Output hoac ten file sai!!!');
   writeln('Diem test ',test,' bang 0');
   readln;halt;
   end;
{$I+}
while not(eof(f)) do
      begin
      readln(f,x);cs[x]:=1;inc(khs);
      end;
close(f);
erase(f);
end;
function min(a,b:word):word;
begin
if a<=b then min:=a else min:=b;
end;
function gan(x:byte):word;
var
   i,j:byte;yt,yp:word;
begin
if cs[x]=1 then begin gan:=0;exit;end;
if x>1 then
   begin
   i:=x;yt:=0;
   while (i>0)and(cs[i]=0) do
      begin
      yt:=yt+lt[i];
      dec(i);
      end;
   if i=0 then yt:=maxint;
   end
   else yt:=maxint;
if x<n then
   begin
   i:=x;yp:=0;
   while (i<n)and(cs[i]=0) do
      begin
      yp:=yp+d[i+1]-d[i];
      inc(i);
      end;
   if i=n+1 then yp:=maxint;
   end
   else yp:=maxint;
gan:=min(yt,yp);
end;
procedure tinhkchs;
{Tinh khoang cach cua hoc sinh}
var
   u:byte;
begin
kchs:=0;
for u:=1 to n do if gan(u)>kchs then kchs:=gan(u);
end;
procedure cham;
{Cham bai}
var
   i:byte;
begin
if khs>k then
   begin
   writeln('So bon xang dung nhieu hon so cho phep');
   writeln('Diem cua test ',test,' bang 0');exit;
   end;
if kchs>kc then
   begin
   writeln('Khoang cach cua hoc sinh: ',kchs);
   writeln('Khoang cach toi uu: ',kc);
   writeln('Diem cua test ',test,' bang 0');exit;
   end;
if kchs=kc then
   begin
   writeln('Ket qua dung!!!');
   writeln('Diem test ',test,' bang 2');
   end;
end;
BEGIN
clrscr;
write('Cham test thu ');readln(test);str(test,s);
fi:='vitri.in'+s;
fo:='vitri.ou'+s;
nhap;doc;tinhkchs;
cham;
readln;
END.