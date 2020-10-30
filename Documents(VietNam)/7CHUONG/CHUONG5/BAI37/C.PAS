uses crt;
const
     fhs='subset.out';
     fi='subset.inp';
     fo='subset.txt';
var
   f,g,h:text;
   n,s1,s2,k,sai,yc:longint;
procedure cham1;
begin
while not(seekeoln(g)) do
      begin
      read(g,s1);read(h,s2);
      if s1<>s2 then inc(sai);
      end;
readln(g);readln(h);
end;
procedure cham2;
begin
readln(g,s1);readln(h,s2);
if s1<>s2 then inc(sai);
end;
procedure cham;
begin
assign(f,fi);reset(f);
assign(g,fo);reset(g);
assign(h,fhs);reset(h);
while not(seekeof(f)) do
      begin
      readln(f,yc);
      if yc=1 then cham1;
      if yc=2 then cham2;
      end;
close(f);close(g);close(h);
end;
BEGIN
clrscr;
sai:=0;cham;
writeln;
writeln('      CO TAT CA 1000 KET QUA');
writeln;
writeln('      SO KET QUA SAI: ',sai);
writeln;readln;
END.