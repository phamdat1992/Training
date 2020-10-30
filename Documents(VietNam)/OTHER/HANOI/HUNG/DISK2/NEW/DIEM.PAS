uses crt;
type point=record
     x,y:integer;
     end;
     lines=record
      x1,x2:point;
      end;
var l:array[1..50] of lines;
    n,i,j:byte;
    f,f1:text;

procedure  readfile;
var  i:byte;
begin
   assign(f,'inp.dat');
   reset(f);
   readln(f,n);
   for i:=1 to n do
     readln(f,l[i].x1.x,l[i].x1.y,l[i].x1.x,l[i].x2.y);
end;

 function min(i,j:integer):integer;
 begin
  min:=i;
  if j<i then min:=j;
 end;

 function  ccw(po,p1,p2:point):integer;
 var   d1x,d2x,d1y,d2y:integer;
 begin
    d1x:=p1.x-po.x; d1y:=p1.y-po.y;
    d2x:=p2.x-po.x; d2y:=p2.y-po.y;
    if d1x*d2y > d2x*d1y then ccw:=1;
    if d1x*d2y < d1y*d2x then ccw:=-1;
    if  d1x*d2y = d1y*d2x then
     begin
     if (abs(po.x)=abs(p1.x)) or ( abs(po.x)=abs(p2.x)) then ccw:=-1
     else
     if (abs(p1.x)<=min(abs(po.x),abs(p2.x)))
     or ((abs(p1.x)>min(abs(po.x),abs(p2.x)))
     and ((abs(p1.x)<abs(po.x)+abs(p2.x)-min(abs(po.x),abs(p2.x))))) then ccw:=1
     else ccw:=-1;
     end;
 end;


  function  intersext(l1,l2:lines):boolean;
  begin
      intersext:=((ccw(l1.x1,l1.x2,l2.x1)*ccw(l1.x1,l1.x2,l2.x2))<=0)
      and ((ccw(l2.x1,l2.x2,l1.x1)*ccw(l2.x1,l2.x2,l1.x2))<=0);

  end;

   begin  clrscr;
     readfile;
     assign(f1,'out.dat');
     rewrite(f1);
     writeln(f1,n);
     for i:=1 to n-1 do
      for j:=i+1 to n do
       begin
       writeln(f1,l[i].x1.x:5,l[i].x1.y:5,l[i].x2.x:5,l[i].x2.y:5);
       writeln(f1,l[j].x1.x:5,l[j].x1.y:5,l[j].x2.x:5,l[j].x2.y:5);
       if intersext(l[i],l[j]) then writeln(f1,' cat nhau')
       else writeln(f1,'khong cat nhau');
       writeln(f1);
       end;
       close(f1);
   end.

  8
  3 9 11 1
  5 15 8 11
  1 6 7 4
  9 7 14 5
  10 13 16 14
  15 2 13 6
  3 12 12 10
  6 8 4 3
8
   11    9    0    1
    8   15    0   11
khong cat nhau

   11    9    0    1
    7    6    0    4
 cat nhau

   11    9    0    1
   14    7    0    5
 cat nhau

   11    9    0    1
   16   13    0   14
khong cat nhau

   11    9    0    1
   13    2    0    6
 cat nhau

   11    9    0    1
   12   12    0   10
khong cat nhau

   11    9    0    1
    4    8    0    3
khong cat nhau

    8   15    0   11
    7    6    0    4
khong cat nhau

    8   15    0   11
   14    7    0    5
khong cat nhau

    8   15    0   11
   16   13    0   14
 cat nhau

    8   15    0   11
   13    2    0    6
khong cat nhau

    8   15    0   11
   12   12    0   10
khong cat nhau

    8   15    0   11
    4    8    0    3
khong cat nhau

    7    6    0    4
   14    7    0    5
khong cat nhau

    7    6    0    4
   16   13    0   14
khong cat nhau

    7    6    0    4
   13    2    0    6
 cat nhau

    7    6    0    4
   12   12    0   10
khong cat nhau

    7    6    0    4
    4    8    0    3
 cat nhau

   14    7    0    5
   16   13    0   14
khong cat nhau

   14    7    0    5
   13    2    0    6
 cat nhau

   14    7    0    5
   12   12    0   10
khong cat nhau

   14    7    0    5
    4    8    0    3
 cat nhau

   16   13    0   14
   13    2    0    6
khong cat nhau

   16   13    0   14
   12   12    0   10
khong cat nhau

   16   13    0   14
    4    8    0    3
khong cat nhau

   13    2    0    6
   12   12    0   10
khong cat nhau

   13    2    0    6
    4    8    0    3
 cat nhau

   12   12    0   10
    4    8    0    3
khong cat nhau

