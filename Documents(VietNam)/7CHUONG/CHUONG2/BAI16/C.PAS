{$M 65000,0,655360}
uses crt;
const
     fi='ch.in';
     fo='ch.ou';
     fhs='ch.out';
type
    dd=array[0..200] of byte;
    dong=array[1..200] of longint;
var
   f:text;c:char;
   t:array[1..200] of ^dong;
   chua:array[1..200] of boolean;
   a:array[1..200,1..200] of byte;
   truoc:dd;
   max,maxhs,mm:longint;
   k1:array[1..200] of longint;
   m,s,n,ch,chon:byte;
procedure nhap;
var
   i,j:byte;k:longint;
begin
assign(f,fi+c);reset(f);
readln(f,n);
for i:=1 to n do
for j:=1 to n do t[i]^[j]:=1000000000;
while not(seekeof(f)) do
      begin
      readln(f,i,j,k);t[i]^[j]:=k;t[j]^[i]:=k;
      end;
close(f);
assign(f,fo+c);reset(f);
readln(f,max);readln(f,max);
close(f);
end;
function lt:boolean;
var
   c,i:byte;
   tp:array[1..200] of byte;
procedure di(i:byte);
var
   j:byte;
begin
tp[i]:=c;
for j:=1 to n do if (tp[j]=0)and(a[i,j]=1) then di(j);
end;
begin
fillchar(tp,sizeof(tp),0);c:=0;
for i:=1 to n do if tp[i]=0 then begin inc(c);di(i);end;
lt:=(c=1);
end;
procedure ijk;
var
   dem,last,j:byte;min:longint;
begin
for j:=1 to n do begin chua[j]:=true;k1[j]:=1000000000;end;
chua[ch]:=false;k1[ch]:=0;last:=ch;
dem:=1;
while dem<n do
      begin
      for j:=1 to n do
      if chua[j] and (a[last,j]=1)
         and (t[last]^[j]<1000000000)and(k1[j]>k1[last]+t[last]^[j]) then
          begin k1[j]:=k1[last]+t[last]^[j];truoc[j]:=last;end;
      min:=1500000000;
      for j:=1 to n do if chua[j] and (k1[j]<min) then
          begin min:=k1[j];last:=j;end;
      chua[last]:=false;inc(dem);
      end;
mm:=k1[1];for j:=2 to n do if k1[j]>mm then mm:=k1[j];
end;
procedure viet;
var
   i,j:byte;
begin
assign(f,fo);rewrite(f);
writeln(f,chon);writeln(f,mm);
for i:=1 to n-1 do
for j:=i+1 to n do if a[i,j]=1 then writeln(f,i:4,j:4);
close(f);
end;
procedure cham;
var
   i,j:byte;
begin
assign(f,fhs);reset(f);
readln(f,ch);
if (ch<1)or(ch>n) then
   begin
   writeln('        Ket qua sai: ten nut khong dung ',ch);
   close(f);exit;
   end;
readln(f,maxhs);
fillchar(a,sizeof(a),0);
s:=0;
while not(seekeof(f)) do
      begin
      inc(s);readln(f,i,j);
      if (i<1)or(i>n)or(j<1)or(j>n) then
         begin
         writeln('        Ket qua sai: ten duong khong dung ',i,' - ',j);
         close(f);exit;
         end;
      a[i,j]:=1;a[j,i]:=1;
      end;
close(f);
if not(lt) then
   begin
   writeln('        Ket qua sai: cac doan duong chon khong lien thong');
   exit;
   end;
if s<>n-1 then
   begin
   writeln('        Ket qua sai: so doan duong chon: ',s);
   exit;
   end;
ijk;
if mm<>maxhs then
   begin
   writeln('        Ket qua sai: KC xa nhat thong bao: ',maxhs);
   writeln('                     KC xa nhat tinh duoc: ',mm);
   exit;
   end;
writeln('        Diem test ',c,': ',2*max/maxhs:0:2);
end;
BEGIN
clrscr;
writeln;
write('        CHAM TEST THU ');c:=readkey;writeln(c);
writeln;
for m:=1 to 200 do new(t[m]);
nhap;cham;readln;
for m:=1 to 200 do dispose(t[m]);
END.