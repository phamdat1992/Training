uses crt;
type
   viec=record
    t,d,c,ok:integer;
   end;
   mang=array[1..1000] of viec;
var a:mang;
    f:text;
    n,tong,phat,thuong:integer;
    chiso:array[1..1000] of integer;

procedure readfile;
var i:integer;
begin
 phat:=0;thuong:=0;
 writeln('INPUT:');
 assign(f,'xep_viec.inp');
 reset(f);
 readln(f,n);
 tong:=0;writeln(n);
 for i:=1 to n do
 with a[i] do
  begin
    ok:=0;
    chiso[i]:=0;
    read(f,t,d,c);writeln(t,'  ',d,'  ',c);
    tong:=tong+t;
  end;
 close(f);
end;

procedure xu_li;
var i,d,luu,max:integer;
begin
  d:=0;
  repeat
    inc(d);
    max:=-maxint;
    for i:=1 to n do
     with a[i] do
      if ok=0 then
       if max<c*(d-tong) then
      begin
       max:=c*(d-tong);
       luu:=i;
      end;
    if max>0 then inc(thuong,max)
    else dec(phat,max);
    chiso[d]:=luu;
    a[luu].ok:=1;
    dec(tong,a[luu].t);
  until d>=n;
  writeln('OUTPUT:');
  writeln(thuong);
  writeln(phat);
  for i:=n downto 1 do writeln(chiso[i]);
end;

begin  clrscr;
  readfile;
  xu_li;
  readln;
end.
7
27 58 5
36 52 4
29 97 23
16 26 46
30 60 39
22 90 28
27 39 6

11
17 39 6
23 48 21
29 65 1
37 60 32
25 34 16
47 59 30
22 90 28
27 93 13
41 64 5
5 14 1
21 68 9


