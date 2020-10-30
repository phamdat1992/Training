uses crt;
var a:array[0..15] of shortint;
    n:byte;
    m:longint;
    f:text;
(**)
procedure readfile;
begin
  writeln('INPUT:');
  assign(f,'cantoan.inp');
  reset(f);
  readln(f,n,m);
  writeln(n,'  ',m);
  close(f);
  writeln('OUTPUT:');
end;
(**)
function bieu_dien(i:byte):longint;
var t:longint;j:byte;
begin
 t:=1;
 for j:=1 to i do t:=t*3;
 bieu_dien:=t;
end;
(**)
procedure co_so_3;
var i:byte;
begin
  i:=n;
  repeat
    while bieu_dien(i)>m do dec(i);
    a[i]:=m div bieu_dien(i);
    m:=m-a[i]*bieu_dien(i);
  until m<=0;
end;
(**)
procedure  xuat;
var i:byte;
begin
 for i:=0 to n do
 if a[i]<>0 then write(a[i]*3,'^',i,'  ')
end;
(**)
procedure tham_mi_vien;
var i:byte;
begin
  repeat
   i:=0;
   while (a[i]<2) and (i<=n) do inc(i);
   if i<=n then
     begin
       a[i]:=-1;
       inc(a[i+1]);
     end;
  until i>n;
  xuat;
end;
(**)
begin
 clrscr;
 readfile;
 co_so_3;
 tham_mi_vien;
 readln;
end.

15 100000


