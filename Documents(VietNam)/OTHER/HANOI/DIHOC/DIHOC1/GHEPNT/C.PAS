uses crt;
const
     fhs='gnt.out';
     ghi='c.t';
     fi='gnt.inp';
var
   f,g,h:text;
   so:array[1..50] of extended;
   kt:array[1..600] of extended;
   x:extended;
   sl,sai:longint;
procedure nhap;
var
   i,j:longint;
begin
assign(h,ghi);reset(h);
for i:=1 to 501 do readln(h,kt[i]);
close(h);
assign(f,fi);reset(f);
for i:=1 to 50 do
    begin
    readln(f,j);
    so[i]:=kt[j];
    end;
close(f);
end;
procedure cham;
var
   i:longint;x:extended;
begin
assign(f,fhs);reset(f);
sai:=0;
for i:=1 to 50 do
    begin
    readln(f,x);
    if x<>so[i] then inc(sai);
    end;
close(f);
end;
BEGIN
clrscr;
writeln;
nhap;cham;
writeln('               Co tat ca 50 ket qua');
writeln;
writeln('               Sai ',sai,' ket qua');
readln;
END.