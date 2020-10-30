uses crt;
const
     fi='job.in';
     fo='job.ou';
     fhs='job.out';
type
    ch=array[1..60000] of boolean;
    m=array[1..10000] of word;
var
   d:^m;
   g:array[1..10000] of longint;
   roi:^ch;
   n:word;
   f:text;t:char;
   sc,ts,ths,tg:longint;
procedure nhap;
var
   i:word;
begin
assign(f,fi+t);reset(f);
readln(f,n);
for i:=1 to n do readln(f,d^[i],g[i]);
close(f);
assign(f,fo+t);reset(f);
readln(f,ts);
close(f);
end;
procedure cham;
var
   i,u,v,kt:longint;
begin
assign(f,fhs);reset(f);
readln(f,ths);
tg:=0;kt:=0;
fillchar(roi^,sizeof(roi^),false);
while not(seekeof(f)) do
      begin
      inc(kt);
      readln(f,u,v);
      if (u<1)or(u>n) then
         begin
         writeln('        Ten cong viec sai: ',u);
         writeln('        Diem = 0.00');
         close(f);exit;
         end;
      if v>d^[u] then
         begin
         writeln('        Cong viec ',u,' lam muon hon quy dinh');
         writeln('        Diem = 0.00');
         close(f);exit;
         end;
      inc(tg,g[u]);
      if roi^[u] then
         begin
         writeln('        Gio thu ',u,' lam hon mot viec');
         close(f);exit;
         end
      else roi^[u]:=true;
      end;
close(f);
if tg<>ths then
   begin
   writeln('        Tong gia tri thong bao: ',ths);
   writeln('        Tong gia tri tinh theo cong viec: ',tg);
   writeln('        Diem = 0.00');
   exit;
   end;
{if kt<>sc then
   begin
   writeln('        So cong viec lam thong bao: ',sc);
   writeln('        So cong viec thuc su lam: ',kt);
   writeln('        Diem = 0.00');
   exit;
   end;}
writeln('        Tong gia tri HS thu duoc: ',ths);
writeln('        Tong gia tri DA thu duoc: ',ts);
writeln('        Diem test ',t,': ',2*sqr(ths/ts):0:2);
end;
BEGIN
clrscr;
new(roi);new(d);
writeln;
write('         CHAM TEST THU ');t:=readkey;writeln(t);
writeln;
nhap;cham;
readln;
dispose(roi);dispose(d);
END.