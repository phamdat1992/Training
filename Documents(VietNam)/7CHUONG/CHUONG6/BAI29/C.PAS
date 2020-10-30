{$R+}
uses crt;
const
     fhs='string.out';
var
   dem,sl,slhs,m,mhs:longint;
   f:text;
   xau,xauhs:array[1..1000] of char;
   fo,test:string;
   day,dayhs:array[1..1000] of longint;
procedure nhap;
begin
assign(f,fo);reset(f);
sl:=0;
while not(seekeoln(f)) do
      begin inc(sl);read(f,day[sl]);end;
readln(f);
m:=0;
while not(eoln(f)) do begin inc(m);read(f,xau[m]);end;readln(f);
close(f);
end;
procedure cham1;
begin
assign(f,fhs);reset(f);
slhs:=0;
while not(seekeoln(f)) do
      begin
      inc(slhs);read(f,dayhs[slhs]);
      if dayhs[slhs]<>day[slhs] then
         begin
         writeln('            Day ma hoa sai tu so hang thu ',slhs);
         readln(f);exit;
         end;
      end;
readln(f);
writeln('            Cau 1 dung!!!');
end;
procedure cham2;
var
   i:longint;
begin
mhs:=0;
while not(eoln(f)) do begin inc(mhs);read(f,xauhs[mhs]);end;readln(f);
if m<>mhs then
   begin
   writeln('            Cau 2 sai');
   writeln('            Day giai ma sai: do dai khong dung!!!');
   close(f);exit;
   end;
for i:=1 to m do if xau[i]<>xauhs[i] then
   begin
   writeln('            Cau 2 sai');
   writeln('            Day giai ma sai tai ky tu thu ',i);
   close(f);exit;
   end;
close(f);
writeln('            Cau 2 dung!!!');
end;
BEGIN
clrscr;
writeln;
write('        CHAM TEST THU ');readln(test);
writeln;
fo:='string.ou'+test;
nhap;cham1;
writeln;cham2;erase(f);
readln;
END.