var n,m:longint;
    d:int64;
    a:array[1..11] of int64;
    l:array[1..11] of longint;
procedure df;
begin
   readln(n,m);
end;
procedure khoitao;
begin
   a[1]:=9;
   a[2]:=99;
   a[3]:=999;
   a[4]:=9999;
   a[5]:=99999;
   a[6]:=999999;
   a[7]:=9999999;
   a[8]:=99999999;
   a[9]:=999999999;
   a[10]:=9999999999;
   a[11]:=99999999999;
end;
function max(a:longint;b:int64):int64;
begin
   if a>b then max:=a else max:=b;
end;
procedure xl;
var k:int64;
    i:longint;
begin
   if m>n then begin d:=-1;exit;end;
   if m=n then begin d:=(n-1) div 9 +1;exit;end;
   k:=n-m;
   for i:=11 downto 1 do
      while k>=a[i] do
         begin
            k:=k-a[i];
            inc(l[i]);
         end;
   d:=0;
   for i:=1 to 11 do
      d:=max(l[i],d);
end;
procedure gf;
begin
  writeln(d);
end;
begin
   df;
   khoitao;
   xl;
   gf;
end.
