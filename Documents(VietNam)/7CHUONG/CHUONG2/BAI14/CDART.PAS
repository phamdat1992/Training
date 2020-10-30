{$M 65000,0,655360}
uses crt;
const
     fi='dart.in';
     fhs='dart.out';
     bb='bb.';
type
    day=array[1..1000] of longint;
var
   f,g:text;t:char;ph:string;
   a1,a2,b1,b2,d1,d2,c1,c2:day;
   dd1,dd2:^day;
   l1:array[1..1000] of char;
   da,m,n,ddd,dhs:longint;
procedure nhap;
var
   i,j,k,u,v,w1,w2:longint;c:char;s,s1:string;code:integer;
begin
assign(f,fi+t);reset(f);
readln(f,n);m:=0;
for i:=1 to n do
    begin
    d1[i]:=n;d2[i]:=n;c1[i]:=0;c2[i]:=0;
    end;
while not(seekeof(f)) do
      begin
      inc(m);
      read(f,u,v,w1,w2);
      if not(seekeoln(f)) then readln(f,c);
      a1[m]:=u;a2[m]:=v;dd1^[m]:=w1;b1[m]:=v;b2[m]:=u;l1[m]:=c;dd2^[m]:=w2;
      if d1[u]>m then d1[u]:=m;if d2[v]>m then d2[v]:=m;
      if c1[u]<m then c1[u]:=m;if c2[v]<m then c2[v]:=m;
      end;
close(f);
assign(f,bb+t);reset(f);
readln(f,da);
close(f);
end;
function VG(u,v:longint):char;
{Vong gac dau U cua duong thu V}
var
   w:longint;
begin
if a1[v]=u then vg:=l1[v] else if l1[v]='M' then vg:='G' else vg:='M';
end;
procedure cham;
var
   duong,d:array[1..200] of longint;

   s,sd,x:longint;
begin
assign(f,fhs);reset(f);
readln(f,dhs);
s:=0;
while not(seekeoln(f)) do
      begin
      inc(s);read(f,d[s]);
      if (d[s]<1)or(d[s]>n) then
         begin
         writeln('    Ten thanh pho thu ',s,' sai: ',d[s]);
         close(f);exit;
         end;
      end;
readln(f);
if (d[1]<>n) then
   begin
   writeln('    Hanh trinh khong bat dau tu que ma tu ',d[1]);
   close(f);exit;
   end;
if (d[s]<>1) then
   begin
   writeln('    Hanh trinh khong ket thuc o Paris ma o ',d[s]);
   close(f);exit;
   end;
sd:=0;ddd:=0;
while not(seekeoln(f)) do
      begin
      inc(sd);read(f,x);
      if (x<1)or(x>m) then
         begin
         writeln('    So hieu doan duong sai: ',x);
         close(f);exit;
         end;
      duong[sd]:=x;
      if (a1[x]=d[sd])and(a2[x]=d[sd+1])
      then
         begin
         inc(ddd,dd1^[x]);
         if sd>1 then if vg(d[sd],duong[sd-1])<>vg(d[sd],x) then
         begin
         writeln('    VG vao TP ',d[sd],' khong cung VG ra khoi TP ',d[sd]);
         close(f);exit;
         end;
         end
      else
      if (b1[x]=d[sd])and(b2[x]=d[sd+1])
      then
         begin
         inc(ddd,dd2^[x]);
         if sd>1 then if vg(d[sd],duong[sd-1])<>vg(d[sd],x) then
         begin
         writeln('    VG vao TP ',d[sd],' khong cung VG ra khoi TP ',d[sd]);
         close(f);exit;
         end;
         end
      else
          begin
          writeln('    Duong di thu ',x,' khong di tu ',d[sd],' den ',d[sd+1]);
          close(f);exit;
          end;
      end;
close(f);
if ddd<>dhs then
   begin
   writeln('    Thoi gian thong bao: ',dhs);
   writeln('    Thoi gian tinh theo duong di: ',ddd);
   exit;
   end;
writeln('    Thoi gian di duong cua HS: ',dhs);
writeln('    Thoi gian di duong cua DA: ',da);
end;
BEGIN
clrscr;
new(dd1);new(dd2);
writeln;
write('CHAM TEST THU ');t:=readkey;writeln(t);
writeln;
nhap;cham;
readln;
dispose(dd1);dispose(dd2);
END.