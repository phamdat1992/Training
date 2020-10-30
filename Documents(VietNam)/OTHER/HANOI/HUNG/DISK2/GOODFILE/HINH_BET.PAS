 uses  crt;
 type hinh=record
       x,y,h:integer;
      end;
 var   a:array[1..200] of hinh;
       f:text;
       n:byte;minx:integer;

 procedure readfile;
 var i:byte;
 begin
  writeln('INPUT:');
  minx:=maxint;
  assign(f,'hinh_bet.inp');
  reset(f);
  readln(f,n);
  for i:=1 to n do
   with a[i] do
     begin
       readln(f,x,y,h);
       if x<minx then minx:=x;
       writeln(x:5,y:5,h:5);
     end;
 end;

 procedure tim_duong1(k:integer);
 var
 begin
   for i:=1 to n do
    if a[i].x=a[k].x then
