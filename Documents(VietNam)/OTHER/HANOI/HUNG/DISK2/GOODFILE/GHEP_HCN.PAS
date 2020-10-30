(*ghep hinh chu nhat sao cho dien tich la lon nhat.(BAI 1 THI HSG TQ 1998*)
uses crt;
type  mang=array[1..1000] of integer;
var  a,a1:mang;
     f,f1,f2:text;
     dem,s,n:longint;

procedure readfile;
var ch:char;st:longint;
begin
 s:=0;n:=0;
 assign(f,'ghep_cn.inp');
 reset(f);
 dem:=0;
 while not eof(f) do
  begin
   st:=0;
   while not eoln(f) do
     begin
       read(f,ch);
       if ch=' ' then
        begin
         if st>0 then begin inc(dem);a[dem]:=st;end;
         st:=0;
        end
       else inc(st);
     end;
     if st>0 then begin inc(dem);a[dem]:=st;end;
    readln(f);
  end;
  for st:=1 to dem do a1[st]:=st;
end;

procedure Quicksort(l, r: integer);
var
  i, j, x1, y1: integer;
begin
  i := l; j := r; x1 := a[(l+r) DIV 2];
  repeat
    while a[i] > x1 do i := i + 1;
    while x1 > a[j] do j := j - 1;
    if i <= j then
    begin
      y1 := a[i]; a[i] := a[j]; a[j] := y1;
      y1:=a1[i];a1[i]:=a1[j];a1[j]:=y1;
      i := i + 1; j := j - 1;
    end;
  until i > j;
  if l < j then Quicksort(l,j);
  if i < r then Quicksort(i,r);
end;

procedure writefile;
var i,x,y,z,t:longint;
begin
 assign(f2,'ghep_cn.out');
 rewrite(f2);
 writeln(f2,s:6,n:6);
 assign(f1,'dat.inp');
 reset(f1);
 for i:=1 to n do
  begin
    readln(f1,x,y,z,t);
    writeln(f2,x:6,y:6,z:6,t:6);
  end;
 close(f1);
 close(f2);
end;

procedure xuli;
var i,j:integer;
begin
  assign(f1,'dat.inp');
  rewrite(f1);
  i:=1;
  repeat
    if a[i+1]=a[i] then
     begin
      j:=i+2;
      while (a[j]<>a[j+1]) and (j<=dem-1) do inc(j);
      if j<=dem-1 then
      begin
       inc(n);inc(s,a[i]*a[j]);
       writeln(f1,a1[i],a1[i+1]:5,a1[j]:5,a1[j+1]:5);
       i:=j+2;
      end
      else begin close(f1);exit;end;
     end
    else  inc(i);
 until i>=dem;
close(f1);
end;

begin  clrscr;
 readfile;
 Quicksort(1,dem);
 xuli;
 writefile;
end.
.............  .....  ......  ...  ...  ......
....    .....   ...  ...  ..  ...... .....
.............  ....  ............ ...... ......
...
.
.
...
....... ....... ...........................
.... ..... .... ...........................

