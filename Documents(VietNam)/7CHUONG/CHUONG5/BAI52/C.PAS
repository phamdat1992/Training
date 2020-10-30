{$M 65000,0,655360}
uses crt;
const
     m=10000;
     fi='dckt.in';
     fo='dckt.ou';
     fhs='dckt.out';
var
   a,x:array[1..m] of word;
   i,j,n,c,chs:word;s,tong:longint;
   f:text;t:char;
procedure nhap;
begin
assign(f,fi+t);reset(f);
n:=0;while not(seekeof(f)) do begin inc(n);readln(f,x[n]);end;
close(f);
assign(f,fo+t);reset(f);
readln(f,c);
close(f);
end;
procedure quicksort(dau,cuoi:word);
var
   tg,i,j:word;
begin
if dau>=cuoi then exit;
i:=dau+1;
while (i<=cuoi)and(a[i]<=a[dau]) do inc(i);
j:=cuoi;
while (j>dau)and(a[j]>=a[dau]) do dec(j);
while i<j do
      begin
      tg:=a[i];a[i]:=a[j];a[j]:=tg;
      inc(i);
      while (i<=cuoi)and(a[i]<=a[dau]) do inc(i);
      dec(j);
      while (j>dau)and(a[j]>=a[dau]) do dec(j);
      end;
tg:=a[dau];a[dau]:=a[j];a[j]:=tg;
quicksort(dau,j-1); quicksort(j+1,cuoi);
end;
procedure cham;
var
	u,v:word;
begin
assign(f,fhs);reset(f);
readln(f,chs);
if ((c=0)and(chs>0))or((chs=0)and(c>0)) then
   begin
   writeln('Ket qua sai');
   close(f);exit;
   end;
s:=0;
if chs>0 then
   begin
   for i:=1 to chs do
       begin
       readln(f,j);
       if (j<0)or(j>n) then
          begin
          writeln('Ket qua sai: chi so khong dung: ',j);
          close(f);exit;
          end;
       a[i]:=x[j];inc(s,a[i]);
       end;
   end;
close(f);
for i:=1 to 100 do
	begin
	u:=1+random(c);v:=1+random(c);
    j:=a[u];a[u]:=a[v];a[v]:=j;
    end;
quicksort(1,c);
tong:=0;
tong:=tong+a[c]+a[c-1]+a[c-2];dec(s,tong);
if tong>s then
   begin
   writeln('Ket qua sai');
   exit;
   end;
writeln('Ket qua dung!!!');
writeln('So phan tu cua HS: ',chs);
end;
BEGIN
writeln;
write('CHAM TEST THU ');t:=readkey;writeln(t);
writeln;
nhap;cham;readln;
END.

